import 'package:flutter/material.dart';

abstract class Dialogs {
  static Dialog customDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Build a popup with text, input text and button',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Caption text',
                  hintText: 'Placeholder text',
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop({'tested_key': 'tested_value'});
                },
                child: Container(
                  color: Colors.green,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Center(
                    child: Text(
                      'OK!',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
