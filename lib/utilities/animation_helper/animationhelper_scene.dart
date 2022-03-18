import 'package:flutter/material.dart';

class AnimationHelperScene extends StatefulWidget {
  static const String routeName = 'animation_page';
  // ignore: sort_constructors_first
  const AnimationHelperScene({Key? key}) : super(key: key);

  @override
  _AnimationHelperSceneState createState() => _AnimationHelperSceneState();
}

class _AnimationHelperSceneState extends State<AnimationHelperScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation colorAnimation;
  late Animation sizeAnimation;
  late Animation rotateAnimation;

  List<String> menus = [
    'Change color',
    'Transform',
    'Scale',
    'Rotation',
    'Fade',
    'Blink',
    'JSONAnimation'
  ];
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.yellow).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
    sizeAnimation = Tween<double>(begin: 25.0, end: 50.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
    rotateAnimation =
        Tween(begin: 0.0, end: 3.14).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Helper'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 72,
              child: ListView.builder(
                  itemCount: menus.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(menus[index]);
                      },
                      child: Container(
                        height: 48,
                        margin: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(menus[index]),
                        ),
                      ),
                    );
                  }),
            ),
            const Divider(
              height: 1,
              color: Color(0xff707070),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(16),
              color: colorAnimation.value,
            ),
          ],
        ),
      ),
    );
  }
}
