import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalScreen extends StatefulWidget {
  static String tag = 'principal_screen';
  final String title;
  const PrincipalScreen({Key key, this.title = "Principal"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PrincipalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('Sair'),
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.clear();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          )
        ],
      ),
    );
  }
}
