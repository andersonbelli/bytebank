import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclient_transaction.dart';
import 'package:bytebank/models/Contacts.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Progress(),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(fontSize: 24.0, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);

                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                                onConfirm: (String password) {
                              setState(() {
                                _sending = true;
                              });

                              _send(dependencies.transactionWebClient,
                                  transactionCreated, password, context);
                            });
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _send(
    webClient,
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    final Transaction transaction =
        await webClient.save(transactionCreated, password).catchError((e) {
      _showFailure(
        context,
        message: "Timeout submitting transaction, try again",
      );
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailure(context, message: "Http Error: ${e.toString()}");
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailure(context, message: "Error: ${e.toString()}");
    }).whenComplete(
      () => setState(() {
        _sending = false;
      }),
    );

    if (transaction != null) {
      Navigator.pop(context);
      return showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("successful transaction!");
          });
    }
  }

  Future _showFailure(BuildContext context,
      {String message = "Unknown error"}) {
    return showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
