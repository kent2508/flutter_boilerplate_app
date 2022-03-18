import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpb_flutter_boilerplate/scr/core/validator/validator.dart';

class TextFieldInput extends StatelessWidget {
  TextFieldInput({
    Key? key,
    this.controller,
    this.focusNode,
    this.inputDecoration,
    this.autofocus = false,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.scrollPadding = const EdgeInsets.all(0),
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.enabled = true,
    required this.validator,
    this.onTap,
    this.onChange,
    this.onSubmitted,
    this.onEdittingComplete,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onSave,
  })  : assert(
            (validator is UserNameInputValidator) ||
                (validator is PasswordInputValidator) ||
                (validator is EmailInputValidator) ||
                (validator is NumberInputValidator),
            'Must be specify the Text Input Type and Validator Type of Text Field if you want use them'),
        super(key: key) {
    if (validator is UserNameInputValidator) {
      inputType = TextInputType.text;
    } else if (validator is PasswordInputValidator) {
      inputType = TextInputType.visiblePassword;
    } else if (validator is EmailInputValidator) {
      inputType = TextInputType.emailAddress;
    } else if (validator is NumberInputValidator) {
      inputType = TextInputType.number;
    }
  }

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;
  late final TextInputType inputType;
  final bool autofocus;
  final int maxLines;
  final TextAlign textAlign;
  final bool obscureText;
  final MaxLengthEnforcement maxLengthEnforcement;
  final EdgeInsets scrollPadding;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final Validator validator;
  final Function()? onTap;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final Function()? onEdittingComplete;
  final AutovalidateMode autovalidateMode;
  final Function(String?)? onSave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // define heigth to keep the position's text field ain't changed when displayed error
      height: 80,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: inputDecoration,
        keyboardType: inputType,
        textAlign: textAlign,
        autofocus: autofocus,
        maxLines: maxLines,
        // maxLength parameter to make TextField have counter text input.
        // maxLength: validator.maxLength,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        enabled: enabled,
        onChanged: onChange,
        onEditingComplete: onEdittingComplete,
        autovalidateMode: autovalidateMode,
        onFieldSubmitted: onSubmitted,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            return validator.validate(value);
          }
          return null;
        },
        onTap: onTap,
        onSaved: onSave,
      ),
    );
  }
}
