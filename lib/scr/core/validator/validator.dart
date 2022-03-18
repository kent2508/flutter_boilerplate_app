// let's custom the Regex flexible with your check.
// There is four type Regex that I check.

abstract class Validator {
  Validator({this.maxLength, this.minLength});
  int? maxLength;
  int? minLength;
  String? checkValidate(String textInput, RegExp regExp) {
    if (maxLength != null && textInput.length > maxLength!) {
      return 'Quá số ký tự quy định';
    } else if (minLength != null && textInput.length < minLength!) {
      return 'Chưa đủ số ký tự quy định';
    } else if (!regExp.hasMatch(textInput)) {
      return 'invalid';
    }
    return null;
  }

  String? validate(String textInput);
}

// Validator for Name or UserName
class UserNameInputValidator extends Validator {
  UserNameInputValidator({int? maxLength, int? minLength})
      : super(maxLength: maxLength, minLength: minLength);

  final RegExp regexUserName = RegExp('^[a-zA-Z]{1}[a-zA-Z0-9 ]');

  @override
  String? validate(String textInput) {
    return super.checkValidate(textInput, regexUserName);
  }
}

// Validator for Password
class PasswordInputValidator extends Validator {
  PasswordInputValidator({int? maxLength, int? minLength})
      : super(maxLength: maxLength, minLength: minLength);
  //Minimum eight characters, at least one uppercase letter, one lowercase, one number and one special character:
  final RegExp regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  String? validate(String textInput) {
    if (textInput.length < minLength!) {
      return 'Chưa đủ số ký tự quy định';
    } else if (textInput.length > maxLength!) {
      return 'Quá số ký tự quy định';
    } else {
      return super.checkValidate(textInput, regexPassword);
    }
  }
}

// Validator for number (may it's phone number)
class NumberInputValidator extends Validator {
  NumberInputValidator({int? maxLength, int? minLength})
      : super(maxLength: maxLength, minLength: minLength);

  final RegExp regexPhoneNumber = RegExp('(09|03|07|08|05)+([0-9]{8})');

  @override
  String? validate(String textInput) {
    final validate = super.checkValidate(textInput, regexPhoneNumber);
    print('number validdate $validate');
    if (validate != null && validate == 'invalid') {
      return 'Wrong format';
    } else if (textInput.isEmpty) {
      return 'Input field must not be empty';
    } else {
      return null;
    }
  }
}

// Validator for Email
class EmailInputValidator extends Validator {
  EmailInputValidator({int? maxLength, int? minLength})
      : super(maxLength: maxLength, minLength: minLength);

  final RegExp regexEmail = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  String? validate(String textInput) {
    final validate = super.checkValidate(textInput, regexEmail);
    if (validate != null && validate == 'invalid') {
      if (!textInput.contains('@')) {
        return 'Định dạng email cần theo chuẩn @abc.def';
      }
    } else {
      return validate;
    }
    return null;
  }
}
