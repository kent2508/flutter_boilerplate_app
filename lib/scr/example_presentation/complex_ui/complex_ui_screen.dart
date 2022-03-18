import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vpb_flutter_boilerplate/scr/core/size/size_config.dart';

class ComplexUIScreen extends StatefulWidget {
  const ComplexUIScreen({Key? key}) : super(key: key);

  static const String routeName = 'complex_ui_screen';
  @override
  _ComplexUIScreenState createState() => _ComplexUIScreenState();
}

class _ComplexUIScreenState extends State<ComplexUIScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      final arguments = ModalRoute.of(context)?.settings.arguments ?? {};
      print('arguments: $arguments');
    });
  }

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
                onPressed: () {},
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'Scaled drawer',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {},
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    '3D drawer',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {},
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'New UI',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
