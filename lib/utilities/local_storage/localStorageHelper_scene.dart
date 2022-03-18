import 'package:flutter/material.dart';

import 'localStorageHelper.dart';
import 'user.dart';

class LocalStorageHelperScene extends StatefulWidget {
  static const String routeName = 'localStorage_page';
  // ignore: sort_constructors_first
  const LocalStorageHelperScene({Key? key}) : super(key: key);

  @override
  _LocalStorageHelperSceneState createState() => _LocalStorageHelperSceneState();
}

class _LocalStorageHelperSceneState extends State<LocalStorageHelperScene> {
  final String sharedPrefencesKey = 'vpb_key';
  late bool checkboxValue = false;
  late String resultData = '';
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Local Storage',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Input Data',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextField(
                      controller: textEditingController,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                height: 256,
                decoration: boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Output Data:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      resultData,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                decoration: boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shared Prefences',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (textEditingController.text != '') {
                              final int value =
                                  int.parse(textEditingController.text.trim());
                              LocalStorageHelper.sharedPrefencesSetInt(
                                      sharedPrefencesKey, value)
                                  .whenComplete(
                                      () => textEditingController.clear());
                            } else {
                              print('Input value can not empty');
                            }
                          },
                          child: const Text(
                            'setInt',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (textEditingController.text != '') {
                              final double value = double.parse(
                                  textEditingController.text.trim());
                              LocalStorageHelper.sharedPrefencesSetDouble(
                                      sharedPrefencesKey, value)
                                  .whenComplete(
                                      () => textEditingController.clear());
                            } else {
                              print('Input value can not empty');
                            }
                          },
                          child: const Text(
                            'setDouble',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Checkbox(
                            value: checkboxValue,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue = value!;
                                LocalStorageHelper.sharedPrefencesSetBool(sharedPrefencesKey, value)
                                    .whenComplete(() => textEditingController.clear());
                              });
                            }),
                        ElevatedButton(
                          onPressed: () {
                            if (textEditingController.text != '') {
                              final String value = textEditingController.text;
                              LocalStorageHelper.sharedPrefencesSetString(
                                      sharedPrefencesKey, value)
                                  .whenComplete(
                                      () => textEditingController.clear());
                            } else {
                              print('Input value can not empty');
                            }
                          },
                          child: const Text(
                            'setString',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (sharedPrefencesKey != '') {
                              final dynamic data = await LocalStorageHelper
                                  .sharedPrefencesGetData(sharedPrefencesKey);
                              setState(() {
                                resultData = data.toString();
                              });
                            } else {
                              print('Shared prefences key invalid');
                            }
                          },
                          child: const Text(
                            'Get Data',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (sharedPrefencesKey != '') {
                              LocalStorageHelper.sharedPrefencesRemoveData(
                                      sharedPrefencesKey)
                                  .whenComplete(() => print('Removed'));
                            } else {
                              print('Shared prefences key invalid');
                            }
                          },
                          child: const Text(
                            'Remove Data',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                decoration: boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Write and read files',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (textEditingController.text != '') {
                              LocalStorageHelper.writeToFile(sharedPrefencesKey,
                                      textEditingController.text)
                                  .whenComplete(
                                      () => textEditingController.clear());
                            } else {
                              print('Input data is empty');
                            }
                          },
                          child: const Text(
                            'Write file',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final String content =
                                await LocalStorageHelper.readFromFile(
                                    sharedPrefencesKey);
                            print('Content: $content');
                            setState(() {
                              resultData = content;
                            });
                          },
                          child: const Text(
                            'Read file',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                decoration: boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SQLite',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            LocalStorageHelper.createDatabase(
                                'example',
                                'users',
                                'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,age INTEGER NOT NULL, country TEXT NOT NULL, email TEXT)',
                                1);
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _addDataSQLite,
                          child: const Text(
                            'Insert',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final List<User>? users =
                                await LocalStorageHelper.retrieveTable('users')
                                    as List<User>?;
                            String output = '';
                            if (users == null) {
                              output = 'Database is null';
                            } else {
                              for (var user in users) {
                                output += 'ID: ${user.id}, Name: ${user.name}, Age: ${user.age}, Country: ${user.country}, Email: ${user.email}\n';
                              }
                            }
                            setState(() {
                              resultData = output;
                            });
                          },
                          child: const Text(
                            'Retrieve',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            LocalStorageHelper.deleteRowByID('users', 0);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        //boxShadow: [
        //  BoxShadow(
        //      color: Colors.grey.withOpacity(0.5),
        //      spreadRadius: 5,
        //      blurRadius: 7,
        //      offset: Offset(0, 1))
        //],
        borderRadius: BorderRadius.circular(8));
  }

  late int sqliteID = 0;
  Future<void> _addDataSQLite() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: const Text('Add new user'),
            content: Container(
              height: 224,
              width: MediaQuery.of(context).size.width - 32,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Name:'),
                      ),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            controller: nameController,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('Age:')),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            controller: ageController,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('Country:')),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            controller: countryController,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('Email:')),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            controller: emailController,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCEL'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                textColor: Colors.black,
                onPressed: () async {
                  if (nameController.text != '' &&
                      ageController.text != '' &&
                      countryController.text != '' &&
                      emailController.text != '') {
                    final String name = nameController.text.trim();
                    final int age = int.parse(ageController.text.trim());
                    final String country = countryController.text.trim();
                    final String email = emailController.text.trim();
                    final User newUser = User(
                        id: sqliteID,
                        name: name,
                        age: age,
                        country: country,
                        email: email);
                    final List<User> users = [newUser];
                    final int result =
                        await LocalStorageHelper.insertRow('users', users);
                    if (result < 0) {
                      setState(() {
                        resultData = 'Database is null $resultData';
                      });
                    }
                    print('result: $result');
                    Navigator.pop(context);
                  }
                },
                child: const Text('ADD'),
              ),
            ],
          ),
        );
      },
    );
  }
}
