import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contacts.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

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

                    final Contact newContact = Contact(
                      name,
                      accountNumber,
                    );
                    _save(dependencies.contactDao, newContact, context);
                    setState(() {});
                  },
                ))
          ]),
        ));
  }

  _save(ContactDao contactDao, Contact newContact, BuildContext context) async {
    await contactDao.save(newContact);
    Navigator.pop(context);
  }
}
