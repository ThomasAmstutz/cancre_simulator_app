/* Page d'instructions */

import 'dart:convert';
import 'dart:io';

import 'package:cancre_simulator_app/screens/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gamePage.dart';
import '../globals.dart' as globals;

String gameTitle = globals.gameTitle;
String appBarTitle = globals.gameVersionTitle;
String wifiSSID = globals.wifiSSID;
String nom;

bool showSuivantButton = false;
bool showOKButton = true;
bool isTextFieldReadOnly = false;
final _text = TextEditingController();

class InstructionsPage extends StatefulWidget {
  InstructionsPage({Key key}) : super(key: key);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<InstructionsPage> {
  SharedPreferences sharedPreferences;
  // final _text = TextEditingController();
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
        title: Text(appBarTitle),
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
          Text('$p1', style: headingStyle),
          SizedBox(height: 15),
          Text('$p2', style: headingStyle),
          SizedBox(height: 15),
          TextField(
            controller: _text,
            readOnly: isTextFieldReadOnly,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
              LengthLimitingTextInputFormatter(14)
            ],
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
          SizedBox(height: 15),
          Text('$p3', style: headingStyle),
          SizedBox(height: 180),
          showOKButton
              ? RaisedButton(
                  onPressed: () {
                    setState(() {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                    });
                    if (_validate == false) {
                      setState(() => showSuivantButton = true);
                      setState(() => showOKButton = false);
                      _openConnection();
                    }
                  },
                  child:
                      Text('Définir le nom', style: TextStyle(fontSize: 20.0)),
                )
              : SizedBox(height: 0),
          showSuivantButton
              ? RaisedButton(
                  onPressed: () {
                    setState(() {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                    });
                    if (_validate == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GamePage(
                                nomJoueur: nom,
                                title: '$gameTitle',
                                socket: socket)),
                      );
                    } else {
                      setState(() => showSuivantButton = false);
                      setState(() => showOKButton = true);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Jouer', style: TextStyle(fontSize: 20.0)),
                      //SizedBox(width: 10.0),
                      //Icon(Icons.chevron_right),
                    ],
                  ),
                )
              : SizedBox(height: 0),
        ]),
      ]),
    );
  }
}

_openConnection() async {
  isTextFieldReadOnly = true;

  // Ouverture de la connexion
  socket = await Socket.connect('$ip', int.parse(port));

  // Réception et traitement du packet
  socket.listen((List<int> event) {
    int newClientId = int.parse(event.toString().substring(142, 144));
    globals.id = newClientId;
  });

}

final String p1 = '1. Connectez-vous au réseau Wifi du stand ($wifiSSID)';
final String p2 =
    '2. Choisissez un nom (sera affiché sur le tableau des scores) et appuyez sur Suivant';
final String p3 = '3. Appuyez sur Jouer';