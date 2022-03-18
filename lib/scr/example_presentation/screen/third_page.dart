import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpb_flutter_boilerplate/constants.dart';
import 'package:vpb_flutter_boilerplate/scr/core/validator/validator.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/custom_widgets/text_field_input.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  static const String routeName = 'third_page';

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final TextEditingController _textNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                TextFieldInput(
                  controller: _textNameController,
                  // let's define max length of TextField and see displayed its
                  validator:
                      UserNameInputValidator(maxLength: 29, minLength: 5),
                  inputDecoration: InputDecoration(
                    // let's custom the UI of TextField by params border
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Name',
                    hintText: 'Name',
                  ),
                ),
                TextFormField(
                  validator: nameValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Name Validator Package',
                    hintText: 'Name Validator Package',
                  ),
                  onChanged: (val) => password = val,
                ),
                const SizedBox(
                  height: kValidatorPadding,
                ),
                TextFieldInput(
                  validator: NumberInputValidator(),
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  inputDecoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Number',
                    hintText: 'Number',
                  ),
                ),
                TextFormField(
                  validator: numberValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Number Validator Package',
                    hintText: 'Number Validator Package',
                  ),
                  onChanged: (val) => password = val,
                ),
                const SizedBox(
                  height: kValidatorPadding,
                ),
                TextFieldInput(
                  validator: EmailInputValidator(minLength: 5, maxLength: 30),
                  inputDecoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  validator: emailValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Email Validator Package',
                    hintText: 'Email Validator Package',
                  ),
                  onChanged: (val) => password = val,
                ),
                const SizedBox(
                  height: kValidatorPadding,
                ),
                TextFieldInput(
                  validator:
                      PasswordInputValidator(minLength: 5, maxLength: 30),
                  inputDecoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Password',
                    hintText: 'Password',
                  ),
                ),
                TextFormField(
                  validator: passwordValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Password Package',
                    hintText: 'Password Package',
                  ),
                  onChanged: (val) => password = val,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final nameValidator =
      PatternValidator('^[a-zA-Z]{1}[a-zA-Z0-9 ]', errorText: 'number error');
  final numberValidator = PatternValidator(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
      errorText: 'number error');
  final emailValidator =
      EmailValidator(errorText: 'enter a valid email address');
  late String password;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
        errorText: 'passwords must have at least one special character')
  ]);
}
