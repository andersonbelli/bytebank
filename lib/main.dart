import 'package:bytebank/database/app_database.dart';
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';
import 'http/webclient.dart';
import 'models/Contacts.dart';
import 'models/transaction.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.green[900],
//          accentColor: Colors.blueAccent[700],
          accentColor: Colors.white,
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.white),
              title: TextStyle(fontSize: 24)),
          iconTheme: IconThemeData(color: Colors.white),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
//              splashColor: Colors.white70,
//              highlightColor: Colors.white70
              textTheme: ButtonTextTheme.accent)),
      home: Dashboard(),
      // home: TransactionAuthDialog(),
    );
  }
}
