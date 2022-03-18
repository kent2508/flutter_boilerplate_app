import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vpb_flutter_boilerplate/scr/bloc/bloc_logging_obsever.dart';
import 'package:vpb_flutter_boilerplate/scr/core/api_service/intercepter_logging.dart';
import 'package:vpb_flutter_boilerplate/scr/core/environment/app_env_repository.dart';
import 'package:vpb_flutter_boilerplate/scr/core/environment/app_environment.dart';
import 'package:vpb_flutter_boilerplate/scr/core/language/app_translate.dart';
import 'package:vpb_flutter_boilerplate/scr/core/language/locales.dart';
import 'package:vpb_flutter_boilerplate/scr/core/routes/navigator_observer.dart';
import 'package:vpb_flutter_boilerplate/scr/data/repository/exam_repository.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/screen/second_page.dart';
import 'package:vpb_flutter_boilerplate/theme/theme_manager.dart';

import 'scr/core/api_service/api_provider.dart';
import 'scr/core/routes/routes.dart';
import 'scr/example_presentation/screen/first_page.dart';
import 'theme/theme_templates.dart';

// let's implements handle message when user tapping on the noti
Future<void> _firebaseMessagingTappingHandler(RemoteMessage message) async {
  print('Handling message ${message.notification?.body}');
  // example
  await Navigator.of(globalKeyFistPageState.currentContext!).pushNamed(
    SecondPage.routeName,
    arguments: {'title': message.notification?.body},
  );
}

Future<void> initializeFirebaseMessage() async {
  await Firebase.initializeApp();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  if (Platform.isIOS) {
    print('firebaseToken: ' + (await firebaseMessaging.getAPNSToken()).toString());
  } else if (Platform.isAndroid) {
    print('firebaseToken: ' + (await firebaseMessaging.getToken()).toString());
  }

  final NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // author this app registed from firebase
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('FCM: User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('FCM: User granted provisional permission');
  } else {
    print('FCM: User declined or has not accepted permission');
  }

  // init notifi while app in foreground, only ios devices
  // await firebaseMessaging.setForegroundNotificationPresentationOptions(
  //     // alert: true, // Required to display a heads up notification
  //     // badge: true,
  //     // sound: true,
  //     );

  // init the way receive Noti when app in the terminated; required app have the one time initilizial
  await firebaseMessaging.getInitialMessage().then((message) {
    if (message != null) {
      print('Got a message whilst in the terminal!');
      _firebaseMessagingTappingHandler(message);
    }
  });

  // also handle any interaction when the app is in the background via a Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the background!');
    _firebaseMessagingTappingHandler(message);
  });

  // initialMessage.sendMessage()
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.title}');
        if (Platform.isIOS) {
          return showDialog(
            context: globalKeyFistPageState.currentContext!, // ?? GlobalKey().currentContext!,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(message.notification?.title ?? 'Notification'),
              content: Text(message.notification?.body ?? 'Detail notification'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                )
              ],
            ),
          );
        } else if (Platform.isAndroid) {
          return showDialog(
            context: globalKeyFistPageState.currentContext!,
            builder: (context) => AlertDialog(
              title: Text(message.notification?.title ?? 'Notification'),
              content: Text(message.notification?.body ?? 'Detail notification'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                )
              ],
            ),
          );
        }
      }
    },
  );
}

void mainDelegate(AppEnvironment appEvironment) {
  // init bloc obsever for control bloc
  Bloc.observer = AppBlocLoggingObserver();

  // init WidgetsFlutterBinding to listen method call from app native
  WidgetsFlutterBinding.ensureInitialized();

  // init your environment
  final environment = AppEvnRepository(appEvironment);

  // init dio repository to call api during the time used app
  // let's custom if you want
  final dioRepository = Dio(
    BaseOptions(
      baseUrl: environment.baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.json,
    ),
  )..interceptors.add(AppInterceptorLogging());

  // init language following native app. may you should implements this.
  AppTranslate.setLanguage(SupportLanguages.Vi);

  // read themes in local storage
  ThemeManager().readJson(completion: () {
    runZonedGuarded(() async {
      if (!kDebugMode) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      }
      runApp(MyApp(
        dioRepository: dioRepository,
      ));
      await initializeFirebaseMessage();
    }, (error, stackTrace) async {
      // do what we want with error
      // maybe we will implement Sentry or Fabric here
      await FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: 'a non-fatal error');
    });
  });
}

final GlobalKey<FirstPageState> globalKeyFistPageState = GlobalKey<FirstPageState>();

// let's change the name app
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.dioRepository,
  }) : super(key: key);
  final Dio dioRepository;

  @override
  Widget build(BuildContext context) {
    // declare all neccessary global reposity/instance to widgets
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiProviderRepositoryImpl>(
          create: (context) => ApiProviderRepositoryImpl(dioRepository),
        ),
        RepositoryProvider<ExamRepositoryImp>(
          create: (context) => ExamRepositoryImp(
            RepositoryProvider.of<ApiProviderRepositoryImpl>(context),
          ),
        ),
      ],
      // declare all neccessary global Bloc providers here
      child: MaterialApp(
        routes: routes,
        home: FirstPage(
          key: globalKeyFistPageState,
        ),
        onGenerateRoute: generateRoutes,
        supportedLocales: LocaleManager.validateLocales(),
        locale: LocaleManager.defaultLocale(),
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          AppLoggingRoutesObserver(),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
