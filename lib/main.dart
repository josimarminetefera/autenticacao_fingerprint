import 'package:autenticacao_fingerprint/principal_screen.dart';
import 'package:flutter/material.dart';

import 'apresentacao_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Autenticação",
      debugShowCheckedModeBanner: false,
      home: ApresentacaoScreen(),
      routes: {
        ApresentacaoScreen.tag: (context) => ApresentacaoScreen(),
        LoginScreen.tag: (context) => LoginScreen(),
        PrincipalScreen.tag: (context) => PrincipalScreen(),
      },
    );
  }
}
