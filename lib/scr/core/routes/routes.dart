import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/complex_ui/complex_ui_screen.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/popup/popup_demo_screen.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/screen/first_page.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/intro/intro_screen.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/listview_example/listview_page.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/otp_example/otp_page.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/screen/second_page.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/screen/third_page.dart';
import 'package:vpb_flutter_boilerplate/utilities/animation_helper/animationhelper_scene.dart';
import 'package:vpb_flutter_boilerplate/utilities/candlestick/candlesstick_scene.dart';
import 'package:vpb_flutter_boilerplate/utilities/image_helper/imagehelper_scene.dart';
import 'package:vpb_flutter_boilerplate/utilities/local_storage/localStorageHelper_scene.dart';

final Map<String, WidgetBuilder> routes = {
  FirstPage.routeName: (context) => const FirstPage(),
  ImageHelperScene.routeName: (context) => const ImageHelperScene(),
  LocalStorageHelperScene.routeName: (context) =>
      const LocalStorageHelperScene(),
  AnimationHelperScene.routeName: (context) => const AnimationHelperScene(),
  CandlesStickScene.ruoteName: (context) => const CandlesStickScene(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  OTPScene.routeName: (context) => const OTPScene(),
  ListViewScene.routeName: (context) => const ListViewScene(),
  ThirdPage.routeName: (context) => const ThirdPage(),
  PopupDemoScreen.routeName: (context) => const PopupDemoScreen(),
  ComplexUIScreen.routeName: (context) => const ComplexUIScreen(),
};

// to pass argument to another page, let's define them is here
Route<MaterialPageRoute>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SecondPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => SecondPage(
          title: (settings.arguments as Map<String, dynamic>)['title'],
        ),
      );
    default:
      return null;
  }
}
