import 'dart:async';

import 'package:flutter/material.dart';

class OTPScene extends StatefulWidget {
  const OTPScene({Key? key}) : super(key: key);
  static String routeName = '/otpScene';
  @override
  _OTPSceneState createState() => _OTPSceneState();
}

class _OTPSceneState extends State<OTPScene> {
  late double screenHeight, screenWidth;
  late int curentInput = 1;
  late int maxInput = 4;
  late double inputSize = 64;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    startTimeout();
    isTimeOut = false;
    _controllers = List<TextEditingController>.generate(
        maxInput, (int index) => TextEditingController());
  }

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  bool isTimeOut = false;

  void startTimeout() {
    final duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          print('Time out');
          setState(() {
            isTimeOut = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            args,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Please enter the OTP sent on your registered phone number.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: isTimeOut
                    ? TextButton(
                        autofocus: false,
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {
                          setState(() {
                            startTimeout();
                            isTimeOut = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              'Didn\'t receive the code?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Resend OTP',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      )
                    : Text(
                        timerText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
              ),
              Container(
                width: screenWidth,
                height: 96,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _otpInputField(node, 1),
                    _otpInputField(node, 2),
                    _otpInputField(node, 3),
                    _otpInputField(node, 4),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    String verifyCode = '';
                    for (var controller in _controllers) {
                      verifyCode += controller.text.trim();
                    }
                    print('Verify code:$verifyCode');
                  },
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _otpInputField(FocusScopeNode node, int index) {
    return Container(
      width: inputSize,
      height: inputSize,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.75),
            spreadRadius: -1,
            blurRadius: 2.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: _controllers[index - 1],
        maxLines: 1,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          counterText: '',
        ),
        obscureText: true,
        obscuringCharacter: '*',
        onChanged: (value) {
          if (value != '') {
            //Inputing pin
            if (curentInput != index) {
              _controllers[index - 1].clear();
              final int steps = index - curentInput;
              for (var i = 0; i < steps; i++) {
                node.previousFocus();
              }
              return;
            }
            if (curentInput < maxInput) {
              node.nextFocus();
              curentInput++;
            } else {
              node.unfocus();
            }
          } else {
            //Deleting pin
            if (curentInput != index) {
              for (var i = curentInput; i > index; i--) {
                _controllers[i - 1].clear();
              }
              curentInput = index;
            }
            if (curentInput > 1) {
              node.previousFocus();
              curentInput--;
            } else {
              node.unfocus();
            }
          }
        },
      ),
    );
  }
}
