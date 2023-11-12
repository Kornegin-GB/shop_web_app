import 'package:flutter/material.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';
import 'package:shop_web_app/models/user_model.dart';
import 'package:shop_web_app/models/validate_input_text.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  String _password = '';
  String _userName = '';
  String _email = '';
  String? validEmail = '';

  isValidEmailString() async {
    validEmail = await ValidateInputText().isValidateEmailRegistration(_email);
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
                icon: Icon(Icons.person),
                labelText: 'Enter your Name',
              ),
              onChanged: (value) => _userName = value,
              validator: (value) => ValidateInputText().isValidateName(value!),
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Enter your Email',
                ),
                onChanged: (value) => _email = value.toLowerCase(),
                validator: (value) {
                  return validEmail;
                }),
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
                validator: (value) =>
                    ValidateInputText().isValidatePassword(value!)),
            TextFormField(
              obscureText: _isVisible,
              decoration: InputDecoration(
                icon: const Icon(Icons.key),
                labelText: 'Repeat password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() {
                    _isVisible = !_isVisible;
                  }),
                ),
              ),
              validator: (value) =>
                  ValidateInputText().passwordComparison(_password, value!),
            ),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            ElevatedButton(
              onPressed: () async {
                await isValidEmailString();
                if (_formKey.currentState!.validate()) {
                  UserAuthorizationModel().insertUser(UserModel(
                      userName: _userName,
                      userEmail: _email,
                      userPassword: _password));
                  UserAuthorizationModel().changingAuthorizationScreen();
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'The user has successfully registered',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ));
                }
              },
              child: const Text('SIGNUP'),
            ),
          ],
        ),
      ),
    );
  }
}
