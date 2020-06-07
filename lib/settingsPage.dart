import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

String ipServer = globals.ipServer;
String portServer = globals.portServer;
String displayedIP;
String displayedPort;

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      SharedPreferences.getInstance();
      displayedIP = sharedPreferences.getString('ipSrv');
      if (displayedIP == null) {
        displayedIP = ipServer;
      }
      displayedPort = sharedPreferences.getString('portSrv');
      if (displayedPort == null) {
        displayedPort = portServer;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
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
    return Expanded(
      child: ListView(padding: EdgeInsets.all(16), children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: TextEditingController(text: displayedIP),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adresse IP du serveur',
              ),
              onChanged: (text) {
                _changeIP(text);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: TextEditingController(text: displayedPort),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Port de communication du serveur',
              ),
              onChanged: (text) {
                _changePort(text);
              },
            ),
          ),
        ]),
      ]),
    );
  }
}

_getIP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  displayedIP = prefs.getString('ipSrv') ?? '$ipServer';
  
}

_changeIP(String ip) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('ipSrv', ip);
  _getIP();
  print('Nouvelle IP : $ip');
}



_getPort() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  displayedIP = prefs.getString('portSrv') ?? '$portServer';
  
}

_changePort(String port) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('portSrv', port);
  _getPort();
  print('Nouveau Port : $port');
}
