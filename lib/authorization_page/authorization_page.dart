import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/authorization_page/authentication_form.dart';
import 'package:shop_web_app/authorization_page/authorized_user_page.dart';
import 'package:shop_web_app/authorization_page/registration_form.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    bool isAuthenticationScreen = UserAuthorizationModel().isAuthenticationPage;
    bool isAuthorized =
        context.watch<UserAuthorizationModel>().isAuthenticationUser;
    return (isAuthorized)
        ? const AuthorizedUserPage()
        : Scaffold(
            appBar: AppBar(
              title:
                  Text((isAuthenticationScreen) ? 'Login page' : 'Signup page'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  (isAuthenticationScreen)
                      ? const AuthenticationForm()
                      : const RegistrationForm(),
                  MaterialButton(
                    child: Text(
                      (isAuthenticationScreen) ? 'SIGNUP' : 'LOGIN',
                    ),
                    onPressed: () {
                      UserAuthorizationModel().changingAuthorizationScreen();
                    },
                  )
                ],
              ),
            ),
          );
  }
}
