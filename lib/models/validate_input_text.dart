import 'package:shop_web_app/models/user_authorization_model.dart';

class ValidateInputText {
  ///Проверяем [email] на валидность
  String? isValidateEmail(String email) {
    if (email.isEmpty) {
      return 'The field should not be empty';
    }
    bool valid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!valid) {
      return 'Enter the correct email address';
    }
    return null;
  }

  ///Проверяем введённый [email] существует ли в базе данных
  Future<String?> isValidateEmailRegistration(String email) async {
    String? result = isValidateEmail(email);
    if (result != null) {
      return result;
    }
    var res = await UserAuthorizationModel().userExists(email);
    if (res) {
      return 'A user with this email exists';
    }
    return null;
  }

  ///Зарегистрирован ли пользователь с введённым [email]
  Future<String?> isValidateEmailAuthentication(String email) async {
    String? result = isValidateEmail(email);
    if (result != null) {
      return result;
    }
    var res = await UserAuthorizationModel().userExists(email);
    if (!res) {
      return 'The user with this email is not registered';
    }
    return null;
  }

  /// Проверяем [password] на валидность
  String? isValidatePassword(String password) {
    if (password.isEmpty) {
      return 'The field should not be empty';
    }
    if (password.length < 6) {
      return 'The password is at least 6 characters long';
    }
    return null;
  }

  ///Проверка [password] на совпадение с паролем пользователя c [email]
  Future<String?> isValidatePasswordAuthentication(
      String password, String email) async {
    String? isValidate = isValidatePassword(password);
    if (isValidate != null) {
      return isValidate;
    }
    var res =
        await UserAuthorizationModel().passwordVerification(email, password);
    if (!res) {
      return 'Incorrect password entered';
    }
    return null;
  }

  /// Проверка введённых паролей
  String? passwordComparison(String password, String repPass) {
    if (repPass.isEmpty) {
      return 'The field should not be empty';
    }
    if (password.length != repPass.length) {
      return 'Passwords don\'t match';
    }
    if (!password.contains(repPass)) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  /// Проверяем [userName] на валидность
  String? isValidateName(String userName) {
    if (userName.isEmpty) {
      return 'The field should not be empty';
    }
    return null;
  }
}
