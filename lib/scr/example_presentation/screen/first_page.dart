import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpb_flutter_boilerplate/scr/core/extensions/color_ext.dart';
import 'package:vpb_flutter_boilerplate/scr/core/language/app_translate.dart';
import 'package:vpb_flutter_boilerplate/scr/core/size/size_config.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/complex_ui/complex_ui_screen.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/intro/intro_screen.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/listview_example/listview_page.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/otp_example/otp_page.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/popup/popup_demo_screen.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/screen/second_page.dart';
import 'package:vpb_flutter_boilerplate/scr/core/extensions/string_ext.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/screen/third_page.dart';
import 'package:vpb_flutter_boilerplate/utilities/animation_helper/animationhelper_scene.dart';
import 'package:vpb_flutter_boilerplate/utilities/candlestick/candlesstick_scene.dart';
import 'package:vpb_flutter_boilerplate/utilities/image_helper/imagehelper_scene.dart';
import 'package:vpb_flutter_boilerplate/utilities/local_storage/localStorageHelper_scene.dart';
import 'package:vpb_flutter_boilerplate/scr/core/extensions/num_ext.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  static const String routeName = 'first_page';

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  LocalAuthentication localAuth = LocalAuthentication();
  late bool canCheckBiometrics;

  ScrollController? _listViewController;

  List<Map<String, String>> cellData = <Map<String, String>>[
    {
      'key': '0',
      'title':
          'Change language', // title is defined as a const, so we can not use the localize feature here
    },
    {
      'key': '1',
      'title': 'Try to "Crash" immediately',
    },
    {
      'key': '2',
      'title': 'Try to "Authen" with biometric',
    },
    {
      'key': '3',
      'title': 'Demo "Image helper" widget',
    },
    {
      'key': '4',
      'title': 'Demo "Local storage helper" feature',
    },
    {
      'key': '5',
      'title': 'Try "Animation helper"',
    },
    {
      'key': '6',
      'title': 'Demo Candle Chart',
    },
    {
      'key': '7',
      'title': 'Demo Intro screen',
    },
    {
      'key': '8',
      'title': 'Demo form & validation in screen',
    },
    {
      'key': '9',
      'title': 'Demo OTP screen',
    },
    {
      'key': '10',
      'title': 'Demo infinity list in screen',
    },
    {
      'key': '11',
      'title': 'Demo popup styles',
    },
    {
      'key': '12',
      'title': 'Demo complex UI',
    },
  ];

  late AnimationController _animationController;
  late Animation<Color?> minimizeOpacity;
  late Animation<double> minimizeScale;
  late Animation<Color?> minimizeColor;
  late Animation<double> minimizeTextOpacity;
  late Animation<double> minimizeTranslateDx;
  late Animation<double> minimizeTranslateDy;

  @override
  void dispose() {
    _listViewController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listViewController = ScrollController()
      ..addListener(() {
        // print('offset: ${_listViewController?.offset}');
        if (_listViewController != null) {
          if (_listViewController!.offset >= 0) {
            double aninmatedValue = _listViewController!.offset / 50.0;
            if (aninmatedValue > 1.0) {
              aninmatedValue = 1.0;
            } else {
              if (aninmatedValue < 0.0) {
                aninmatedValue = 0.0;
              }
            }
            _animationController.animateTo(aninmatedValue);
          }
        }
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );

    minimizeOpacity = ColorTween(begin: Colors.grey, end: Colors.transparent)
        .animate(_animationController);
    minimizeTextOpacity =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    minimizeScale =
        Tween<double>(begin: 1.0, end: 0.5).animate(_animationController);
    minimizeColor = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_animationController);
    minimizeTranslateDx =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    minimizeTranslateDy =
        Tween<double>(begin: 0.0, end: -75).animate(_animationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  void simulateCrashAction() {
    FirebaseCrashlytics.instance.crash();
  }

  void activeBiometric() async {
    canCheckBiometrics = await localAuth.canCheckBiometrics;
    final List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();
    try {
      if (canCheckBiometrics && availableBiometrics.isNotEmpty) {
        late final String localizedReason;
        IOSAuthMessages? iosAuthMessages;
        AndroidAuthMessages? androidAuthMessages;
        if (Platform.isIOS) {
          if (availableBiometrics.contains(BiometricType.face)) {
            iosAuthMessages = const IOSAuthMessages(
              cancelButton: 'Hủy',
              goToSettingsButton: 'Cài đặt',
              goToSettingsDescription: 'Vui lòng cái đặt xác thực FaceID',
              lockOut: 'Bạn đã quá số lần thử',
            );
            localizedReason = 'Vui lòng sử dụng FaceID để xác thực';
          } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
            iosAuthMessages = const IOSAuthMessages(
              cancelButton: 'Hủy',
              goToSettingsButton: 'Cài đặt',
              goToSettingsDescription: 'Vui lòng cái đặt xác thực TouchID',
              lockOut: 'Bạn đã quá số lần thử',
            );
            localizedReason = 'Vui lòng sử dụng TouchID để xác thực';
          }
        } else {
          if (availableBiometrics.contains(BiometricType.fingerprint)) {
            androidAuthMessages = const AndroidAuthMessages(
              cancelButton: 'Hủy',
              goToSettingsButton: 'settings',
              goToSettingsDescription:
                  'Vui lòng cài đặt vân tay để sử dụng xác thực',
            );
            localizedReason = 'Vui lòng sử dụng sinh trắc học để xác thực';
          }
        }
        final bool author = await localAuth.authenticate(
          localizedReason: localizedReason,
          useErrorDialogs: true,
          androidAuthStrings:
              androidAuthMessages ?? const AndroidAuthMessages(),
          iOSAuthStrings: iosAuthMessages ?? const IOSAuthMessages(),
          biometricOnly: true,
        );
        print(author);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Handle this exception here.
      }
    }
  }

  void _onSecondPage() {
    Navigator.of(context).push(_customRoute());
    // Navigator.of(context).pushNamed(SecondPage.routeName,
    // arguments: {'title': 'page_2'.localized});
  }

  Route _customRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SecondPage(title: 'Aloha'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // return SlideTransition(
        //     position:
        //         Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        //             .animate(animation),
        //     child: child);
        return ScaleTransition(
          alignment: Alignment.centerRight,
          scale: CurvedAnimation(
            parent: animation,
            curve: const Interval(
              0.00,
              0.50,
              curve: Curves.linearToEaseOut,
            ),
          ),
          child: child,
        );
      },
    );
  }

  List<Widget> _renderTopMenu() {
    const items = [
      {
        'icon': Icons.home,
        'title': 'Test',
      },
      {
        'icon': Icons.home,
        'title': 'Test',
      },
      {
        'icon': Icons.home,
        'title': 'Test',
      },
      {
        'icon': Icons.home,
        'title': 'Test',
      },
    ];

    return items
        .map(
          (item) => AnimatedBuilder(
              animation: _animationController,
              builder: (cxt, widget) {
                return GestureDetector(
                  onTap: () {
                    print('pressed on menu item');
                  },
                  child: Transform.translate(
                    offset: Offset(
                        minimizeTranslateDx.value, minimizeTranslateDy.value),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Transform.scale(
                                scale: minimizeScale.value,
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: minimizeOpacity.value,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('pressed on menu item _');
                                },
                                child: Center(
                                  child: Icon(item['icon'] as IconData,
                                      color: minimizeColor.value),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Opacity(
                          opacity: minimizeTextOpacity.value,
                          child: Transform.scale(
                            scale: minimizeScale.value,
                            child: Text(item['title'] as String),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
        .toList();
  }

  int counter = 60;
  final ValueKey<String> countdownTimerKey = const ValueKey('countdown_timer');

  @override
  Widget build(BuildContext context) {
    print('rerender this widget???');

    // final StatefulBuilder countdown = StatefulBuilder(
    //     key: countdownTimerKey,
    //     builder: (context, setState) {
    //       if (counter > 0) {
    //         Future.delayed(const Duration(seconds: 1), () {
    //           setState(() => counter -= 1);
    //         });
    //       }
    //       return Text('Counter: $counter');
    //     });
    final appBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: appBarHeight,
            child: Container(
              color: Theme.of(context).primaryColor,
              height: appBarHeight,
            ),
          ),
          Positioned(
            top: appBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: ListView.builder(
                  controller: _listViewController,
                  itemCount: cellData.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        color: Colors.white,
                        child: const SizedBox(height: 100),
                      );
                    }
                    if (index == cellData.length + 1) {
                      return Container(
                        color: Colors.white,
                        child: const SizedBox(height: 500),
                      );
                    }
                    return DemoCell(
                      key: ValueKey(index),
                      data: cellData[index - 1],
                      onTap: (cellIndex) {
                        handleTapOnCellAtIndex(cellIndex);
                      },
                    );
                  }),
            ),
          ),
          Positioned(
            top: appBarHeight,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _renderTopMenu(),
              ),
              // child: countdown,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () {
        //   counter = 60;
        //   countdown.builder.call(context, setState);
        // },
        onPressed: _onSecondPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void handleTapOnCellAtIndex(int index) {
    print('current cell index = $index');
    switch (index) {
      case 0:
        if (AppTranslate.currentLanguage == SupportLanguages.Vi) {
          AppTranslate.setLanguage(SupportLanguages.En);
        } else {
          AppTranslate.setLanguage(SupportLanguages.Vi);
        }
        setState(() {});
        break;
      case 1:
        simulateCrashAction();
        break;
      case 2:
        activeBiometric();
        break;
      case 3:
        Navigator.of(context).pushNamed(ImageHelperScene.routeName);
        break;
      case 4:
        Navigator.of(context).pushNamed(LocalStorageHelperScene.routeName);
        break;
      case 5:
        Navigator.of(context).pushNamed(AnimationHelperScene.routeName);
        break;
      case 6:
        Navigator.of(context).pushNamed(CandlesStickScene.ruoteName);
        break;
      case 7:
        Navigator.of(context).pushNamed(IntroScreen.routeName);
        break;
      case 8:
        Navigator.of(context).pushNamed(ThirdPage.routeName);
        break;
      case 9:
        Navigator.of(context)
            .pushNamed(OTPScene.routeName, arguments: cellData[index]['title']);
        break;
      case 10:
        Navigator.of(context).pushNamed(ListViewScene.routeName,
            arguments: cellData[index]['title']);
        break;
      case 11:
        Navigator.of(context).pushNamed(PopupDemoScreen.routeName);
        break;
      case 12:
        Navigator.of(context).pushNamed(ComplexUIScreen.routeName,
            arguments: {'arg1': 'test value'});
        break;
      default:
        break;
    }
  }
}

typedef DemoCellCallback = void Function(int);

// ignore: must_be_immutable
class DemoCell extends StatelessWidget {
  const DemoCell({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);
  final Map<String, String> data;
  final DemoCellCallback onTap;

  @override
  Widget build(BuildContext context) {
    print(key);
    return InkWell(
      onTap: () {
        onTap(int.parse(data['key']!));
      },
      child: Container(
        decoration: BoxDecoration(
          color: (int.parse(data['key']!) % 2 == 0)
              ? Colors.white
              : HexColor.fromHex('#f1f1f1'),
          border:
              const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        width: SizeConfig.screenWidth,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(data['title']!),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
