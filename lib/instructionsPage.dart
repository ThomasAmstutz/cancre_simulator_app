import 'package:flutter/material.dart';
import 'nameSelectionPage.dart';
import 'globals.dart' as globals;

String gamseTitle = globals.gameTitle;
String version = globals.version;
String wifiSSID = globals.wifiSSID;

class InstructionsPage extends StatefulWidget {
  InstructionsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<InstructionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase() + " " + version),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMainContent(),
            // Image.asset('assets/slingshot1.png'),
            // Expanded(
            //   child: Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: MaterialButton(
            //       onPressed: () {},
            //       padding: EdgeInsets.only(
            //           left: 12.0, right: 12.0, top: 10.0, bottom: 10.0),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12.0)),
            //       color: Theme.of(context).primaryColor,
            //       child: Text(
            //         'Suivant',
            //         style: TextStyle(fontSize: 22),
            //       ),
            //     ),
            //   ),
            // ),
            // MaterialButton(
            //   onPressed: () {},
            //   padding: EdgeInsets.only(
            //       left: 12.0, right: 12.0, top: 10.0, bottom: 10.0),
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12.0)),
            //   color: Theme.of(context).primaryColor,
            //   child: Text(
            //     'Suivant',
            //     style: TextStyle(fontSize: 22),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    final theme = Theme.of(context);
    final headingStyle = theme.textTheme.headline6
        .copyWith(fontWeight: FontWeight.bold);
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
          Text('3. Appuyez sur Suivant', style: headingStyle),
          SizedBox(height: 100),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NameSelectionPage(title: '$gameTitle')),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Suivant', style: TextStyle(fontSize: 20.0)),
                SizedBox(width: 10.0),
                Icon(Icons.chevron_right),
              ],
            ),
          )
        ]),
      ]),
    );
  }
}
