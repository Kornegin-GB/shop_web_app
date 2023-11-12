import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';
import 'package:shop_web_app/models/validate_input_text.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  String _email = '';
  String _password = '';
  String? validEmail = '';
  String? validPassword = '';

  isValidEmailString() async {
    validEmail =
        await ValidateInputText().isValidateEmailAuthentication(_email);
  }

  isValidPassword() async {
    validPassword = await ValidateInputText()
        .isValidatePasswordAuthentication(_password, _email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Enter your Email',
              ),
              onChanged: (value) => _email = value.toLowerCase(),
              validator: (value) => validEmail,
            ),
            TextFormField(
              obscureText: _isVisible,
              decoration: InputDecoration(
                icon: const Icon(Icons.key),
                labelText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() {
                    _isVisible = !_isVisible;
                  }),
                ),
              ),
              onChanged: (value) => _password = value,
              validator: (value) => validPassword,
            ),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            ElevatedButton(
              onPressed: () async {
                await isValidEmailString();
                await isValidPassword();
                if (_formKey.currentState!.validate()) {
                  SharedPreferences userAuth =
                      await SharedPreferences.getInstance();
                  await userAuth.setString('email', _email);
                  await UserAuthorizationModel().loadAuthenticationUser();
                  await ShoppingCartModel().loadProduct();
                  UserAuthorizationModel().changingAuthentication();
                }
              },
              child: const Text('LOGIN'),
            )
          ],
        ),
      ),
    );
  }
}
