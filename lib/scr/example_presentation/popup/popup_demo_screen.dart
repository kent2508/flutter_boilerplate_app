import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/scr/core/size/size_config.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/custom_widgets/vpb_popups.dart';

class PopupDemoScreen extends StatefulWidget {
  const PopupDemoScreen({Key? key}) : super(key: key);

  static const String routeName = 'popup_demo_screen';

  @override
  _PopupDemoScreenState createState() => _PopupDemoScreenState();
}

class _PopupDemoScreenState extends State<PopupDemoScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  //..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popups demo'),
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  showDialog(
                          context: context,
                          // useSafeArea: false,
                          // barrierDismissible: true,
                          barrierColor: Colors.transparent,
                          builder: (BuildContext context) =>
                              Dialogs.customDialog(context))
                      .then((value) => print(value));
                },
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'Show as popup',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      // useSafeArea: false,
                      barrierDismissible: false,
                      // barrierColor: Colors.transparent,
                      builder: (BuildContext context) =>
                          Dialogs.customDialog(context));
                },
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'Show as alert',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (BuildContext buildContext,
                        Animation animation, Animation secondaryAnimation) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: MediaQuery.of(context).size.height - 160,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: Text(
                            'Hello dude',
                            style: TextStyle(color: Colors.redAccent),
                          )),
                        ),
                      );
                    },
                    transitionBuilder: (_, anim, __, child) {
                      return customTransition(anim, child);
                    },
                  );
                },
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'Show fullscreen dialog',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )),
          ],
        ),
      ),
    );
  }

  AnimatedWidget customTransition(Animation<double> anim, Widget child) {
    // slide from bottom
    // return SlideTransition(
    //   position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
    //       .animate(anim),
    //   child: child,
    // );

    // scale transition
    final scaleTween = Tween(begin: 0.1, end: 1.1).chain(Tween(begin: 1.1, end: 0.9).chain(Tween(begin: 0.9, end: 1.0))).animate(anim);
    return ScaleTransition(
      scale: scaleTween,
      child: child,
    );
  }
}
