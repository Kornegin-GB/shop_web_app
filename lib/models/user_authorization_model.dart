import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_web_app/database_helper/database_app.dart';
import 'package:shop_web_app/models/user_model.dart';

class UserAuthorizationModel extends ChangeNotifier {
  bool isAuthenticationPage = true;
  bool isAuthenticationUser = false;
  UserModel? _currentUser;
  var mainDb = DatabaseApp.db;

  UserAuthorizationModel._();

  static final UserAuthorizationModel _usersInstance =
      UserAuthorizationModel._();

  factory UserAuthorizationModel() {
    return _usersInstance;
  }

  UserModel? get currentUser => _currentUser;

  Future<void> loadAuthenticationUser() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String? email = sharedUser.getString('email');
    if (email != null) {
      _currentUser = await mainDb.getUser(email);
    }
  }

  ///Запись пользователя [user] в базу данных (регистрация пользователя)
  void insertUser(UserModel user) {
    mainDb.insertUser(user);
  }

  ///Проверяем есть ли пользователь с [email] в базе данных
  Future<bool> userExists(String email) async {
    return await mainDb.userExists(email);
  }

  ///Проверяем совпадает ли введённый пароль с сохранённым
  Future<bool> passwordVerification(String email, String password) async {
    return await mainDb.authorizationUser(email, password);
  }

  ///Метод смены экрана авторизации
  void changingAuthorizationScreen() {
    isAuthenticationPage = !isAuthenticationPage;
    notifyListeners();
  }

  ///Метод смены аутентифицированного пользователя
  void changingAuthentication() {
    isAuthenticationUser = !isAuthenticationUser;
    notifyListeners();
  }
}
