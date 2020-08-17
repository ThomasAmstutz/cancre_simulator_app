import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:developer';
import 'globals.dart' as globals;

String gameTitle = globals.gameTitle;
String version = globals.version;
String wifiSSID = globals.wifiSSID;
String ip;
String port;

Socket socket;
Timer timer;

class GamePage extends StatefulWidget {
  GamePage({Key key, @required this.nomJoueur, this.title}) : super(key: key);

  final String title;
  final String nomJoueur;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<GamePage> {
  SharedPreferences sharedPreferences;
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

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

    _openConnection();

    _sendName();

    // Accelerometer events
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));

    // UserAccelerometer events
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));

    // Gyroscope events
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  Future _openConnection() async {
    socket = await Socket.connect('$ip', int.parse(port));
    log('Connecté');
  }

  _closeConnection() {
    Navigator.pop(context);
    socket.close();
    log('Connexion fermée');
  }

  Future _sendName() async {
    socket.add(utf8.encode(widget.nomJoueur));
    await Future.delayed(Duration(seconds: 2));
    log('Nom envoyé');
  }

  Future _sendClick() async {
    socket.add(utf8.encode("CLIC"));
    await Future.delayed(Duration(seconds: 2));
  }

  Future _sendData(List<String> accelerometer, List<String> gyroscope,
      List<String> userAccelerometer) async {
    socket.add(utf8.encode(accelerometer.toString()));
    socket.add(utf8.encode(gyroscope.toString()));
    socket.add(utf8.encode(userAccelerometer.toString()));
    // await Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    for (StreamSubscription<dynamic> sub in _streamSubscriptions) {
      sub.cancel();
    }
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headingStyle = theme.textTheme.headline6.copyWith(
      fontWeight: FontWeight.bold,
    );

    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    timer = Timer.periodic(Duration(seconds: 2),
        (Timer t) => _sendData(accelerometer, gyroscope, userAccelerometer));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase() + " " + version),
      ),
      body: Center(
        child: ListView(children: [
          SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child:
                Text('Bonne chance ' + widget.nomJoueur, style: headingStyle),
          ),
          SizedBox(height: 60),
          Material(
            child: InkWell(
              onTap: () {
                log('Nom = ' + widget.nomJoueur);
                _sendClick();
              },
              child: Container(
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'assets/slingshot1.png',
                    height: 350,
                    width: 350,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),

          /*  Valeurs envoyées vers le serveur  */
          // SizedBox(height: 40),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Accelerometer: $accelerometer'),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('UserAccelerometer: $userAccelerometer'),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Gyroscope: $gyroscope'),
          // ),

          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              _closeConnection();
            },
            child: Text('Arrêter de jouer', style: TextStyle(fontSize: 20.0)),
          ),
        ]),
      ),
    );
  }
}
