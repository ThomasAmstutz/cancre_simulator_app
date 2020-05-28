import 'package:flutter/material.dart';
import 'globals.dart' as globals;

String gameTitle = globals.gameTitle;
String version = globals.version;
String wifiSSID = globals.wifiSSID;

class NameSelectionPage extends StatefulWidget {
  NameSelectionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NameSelectionState createState() => _NameSelectionState();
}

class _NameSelectionState extends State<NameSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase() + " " + version),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
