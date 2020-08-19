/* Point d'entrée de l'application */

import 'package:flutter/material.dart';
import 'screens/instructionsPage.dart';
import 'globals.dart' as globals;
import 'theme.dart';

String gameTitle = globals.gameTitle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$gameTitle',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: InstructionsPage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title.toUpperCase() + " " + version),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _buildMainContent(),
//             // Image.asset('assets/slingshot1.png'),
//             // Expanded(
//             //   child: Align(
//             //     alignment: FractionalOffset.bottomCenter,
//             //     child: MaterialButton(
//             //       onPressed: () {},
//             //       padding: EdgeInsets.only(
//             //           left: 12.0, right: 12.0, top: 10.0, bottom: 10.0),
//             //       shape: RoundedRectangleBorder(
//             //           borderRadius: BorderRadius.circular(12.0)),
//             //       color: Theme.of(context).primaryColor,
//             //       child: Text(
//             //         'Suivant',
//             //         style: TextStyle(fontSize: 22),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // MaterialButton(
//             //   onPressed: () {},
//             //   padding: EdgeInsets.only(
//             //       left: 12.0, right: 12.0, top: 10.0, bottom: 10.0),
//             //   shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(12.0)),
//             //   color: Theme.of(context).primaryColor,
//             //   child: Text(
//             //     'Suivant',
//             //     style: TextStyle(fontSize: 22),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     final theme = Theme.of(context);
//     final headingStyle = theme.textTheme.headline6
//         .copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor);
//     return Expanded(
//       child: ListView(padding: EdgeInsets.all(16), children: [
//         /*Text(
//           'Bienvenue dans $gameTitle !',
//           style: theme.textTheme.headline5,
//         ),*/
//         // Text(
//         //   '$instructions',
//         //   style: TextStyle(fontSize: 18),
//         // ),
//         //SizedBox(height: 26),
//         Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Text('Instructions :', style: theme.textTheme.headline4),
//           SizedBox(height: 25),
//           Text('1. Connectez-vous au réseau Wifi du stand ($wifiSSID)',
//               style: headingStyle),
//           SizedBox(height: 10),
//           Text('2. Désactivez les données mobiles', style: headingStyle),
//           SizedBox(height: 10),
//           Text('3. Appuyez sur Suivant', style: headingStyle),
//           SizedBox(height: 100),
//           RaisedButton(
//             color: theme.buttonTheme.colorScheme.primary,
//             textColor: Colors.white,
//             onPressed: () {},
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text('Suivant', style: TextStyle(fontSize: 20.0)),
//                 SizedBox(width: 10.0),
//                 Icon(Icons.chevron_right),
//               ],
//             ),
//           )
//         ]),
//       ]),
//     );
//   }
// }
