import 'package:autenticacao_fingerprint/principal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'biometric_login.dart';
import 'constants.dart';

class LoginScreen extends StatelessWidget {
  static String tag = 'login_screen';
  final obscurePassword = ValueNotifier<bool>(true);
  final loginEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildTextField(labelText: 'Login', controller: loginEditingController),
              ValueListenableBuilder(
                valueListenable: obscurePassword,
                builder: (_, obscurePasswordValue, child) {
                  return _buildTextField(
                    controller: passwordEditingController,
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      onPressed: () => obscurePassword.value = !obscurePasswordValue,
                      icon: Icon(obscurePasswordValue ? Icons.lock : Icons.lock_open),
                    ),
                    obscureText: obscurePasswordValue,
                  );
                },
              ),
              RaisedButton(
                onPressed: () {
                  if (loginEditingController.text == "1" && passwordEditingController.text == "1") {
                    _showwDialogBiometrics(context);
                  }
                },
                child: Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({TextEditingController controller, String labelText, Widget suffixIcon, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: labelText, suffixIcon: suffixIcon),
      ),
    );
  }

  Future<void> _showwDialogBiometrics(BuildContext context) async {
    final biometricsAuth = BiometricsLogin();
    if (await biometricsAuth.isBiometricsAuth()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Digital'),
          content: Text('Deseja utilizar sua digital?'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                print("Não quero biometria");
              },
              child: Text('Não'),
            ),
            FlatButton(
              onPressed: () async {
                print("sim");
                SharedPreferences sp = await SharedPreferences.getInstance();
                try {
                  print("biometricsAuth");
                  final auth = await biometricsAuth.auth();
                  if (auth) {
                    Navigator.of(context).pop();
                    sp.setBool(BIOMETRICS_KEY, true);
                    print("deu certo");
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      PrincipalScreen.tag,
                      (Route<dynamic> route) => false,
                    );
                  }
                } on PlatformException catch (e) {
                  print(e);
                  sp.clear();
                  Navigator.of(context).pop();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Digital não configurada'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Sim'),
            ),
          ],
        ),
      );
    } else {
      print("Não tem biometria");
    }
  }
}
