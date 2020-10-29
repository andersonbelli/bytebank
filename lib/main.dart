import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclient_transaction.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';
import 'http/webclient.dart';
import 'models/Contacts.dart';
import 'models/transaction.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  BytebankApp({
    @required this.contactDao,
    @required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
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
      ),
    );
  }
}
