import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';

class AuthorizedUserPage extends StatelessWidget {
  const AuthorizedUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool withCart =
        context.watch<UserAuthorizationModel>().isAuthenticationUser;
    return Scaffold(
      appBar: AppBar(
        title: BuilderAppBar(titleApp: 'User page', withCart: withCart),
      ),
      body: Consumer<UserAuthorizationModel>(
        builder: (context, value, child) => Column(
          children: [
            Text(
              'User name: ${value.currentUser?.userName}',
            ),
            Text(
              'User email: ${value.currentUser?.userEmail}',
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences sharedUser =
                    await SharedPreferences.getInstance();
                sharedUser.remove('email');
                UserAuthorizationModel().changingAuthentication();
                ShoppingCartModel().products.clear();
              },
              child: const Text('EXIT'),
            )
          ],
        ),
      ),
    );
  }
}
