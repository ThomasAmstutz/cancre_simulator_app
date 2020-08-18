import 'dart:convert';
import 'dart:io';

import 'package:cancre_simulator_app/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'gamePage.dart';
import 'globals.dart' as globals;

String gameTitle = globals.gameTitle;
String version = globals.version;
String wifiSSID = globals.wifiSSID;
String nom;

class InstructionsPage extends StatefulWidget {
  InstructionsPage({Key key}) : super(key: key);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<InstructionsPage> {
  SharedPreferences sharedPreferences;
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      SharedPreferences.getInstance();
      ip = sharedPreferences.getString('ipSrv');
      if (ip == null) {
        ip = globals.ipServer;
      }

      port = sharedPreferences.getString('portSrv');
      if (port == null) {
        port = globals.portServer;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameTitle.toUpperCase() + " " + version),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              child: Icon(
                Icons.settings,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    final theme = Theme.of(context);
    final headingStyle =
        theme.textTheme.headline6.copyWith(fontWeight: FontWeight.bold);
    return Expanded(
      child: ListView(padding: EdgeInsets.all(16), children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Instructions :', style: theme.textTheme.headline4),
          SizedBox(height: 25),
          Text('1. Connectez-vous au réseau Wifi du stand ($wifiSSID)',
              style: headingStyle),
          SizedBox(height: 10),
          Text('2. Désactivez les données mobiles', style: headingStyle),
          SizedBox(height: 10),
          Text('3. Choisissez un nom (sera affiché sur le tableau des scores)',
              style: headingStyle),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: _text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Votre Nom',
                errorText: _validate ? 'Saisissez un nom' : null,
                errorStyle: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onChanged: (text) {
                nom = text;
              },
            ),
          ),
          SizedBox(height: 25),
          Text('4. Appuyez sur Suivant', style: headingStyle),
          SizedBox(height: 80),
          RaisedButton(
            onPressed: () {
              _openConnection();
            },
            child: Text('OK', style: TextStyle(fontSize: 20.0)),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
              });
              if (_validate == false) {
                log('Nom = $nom');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(
                          nomJoueur: nom, title: '$gameTitle', socket: socket)),
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Suivant', style: TextStyle(fontSize: 20.0)),
                SizedBox(width: 10.0),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}

_openConnection() async {
  socket = await Socket.connect('$ip', int.parse(port));
  //print(socket);
  await Future.delayed(Duration(seconds: 1));
  // log('Connecté');
  socket.add(utf8.encode("connexion reussie"));
}
