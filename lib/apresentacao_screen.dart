import 'package:autenticacao_fingerprint/biometric_login.dart';
import 'package:autenticacao_fingerprint/principal_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'login_screen.dart';

class ApresentacaoScreen extends StatefulWidget {
  static String tag = 'apresentacao_screen';

  @override
  _ApresentacaoScreenState createState() => _ApresentacaoScreenState();
}

class _ApresentacaoScreenState extends State<ApresentacaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(

                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    verificarBiometria().then((retorno) {
      if (retorno) {
        print("deu tudo certo");
        Navigator.of(context).pushNamedAndRemoveUntil(
          PrincipalScreen.tag,
          (Route<dynamic> route) => false,
        );
      } else {
        print("nao deu biometria");
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.tag,
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  Future<bool> verificarBiometria() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey(BIOMETRICS_KEY) && sp.getBool(BIOMETRICS_KEY)) {
      print("usuário usando biometria");
      final biometricsAuth = await BiometricsLogin().auth();
      if (biometricsAuth) {
        print("certo");
        return true;
      }
    }
    return false;
  }
}
