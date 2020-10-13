import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contacts.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Contact")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: "Full name", labelStyle: TextStyle(fontSize: 24)),
            ),
            TextField(
              controller: _accountController,
              decoration: InputDecoration(
                  labelText: "Account number",
                  labelStyle: TextStyle(fontSize: 24)),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text("Save"),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber =
                        int.tryParse(_accountController.text);

                    final Contact newContact = Contact(3, name, accountNumber);
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                ))
          ]),
        ));
  }
}