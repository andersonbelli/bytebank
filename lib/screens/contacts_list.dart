import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contacts.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final ContactDao contactDao;

  ContactsList({@required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Transfer")),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).backgroundColor,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContactForm(contactDao: contactDao))),
        ),
        body: FutureBuilder<List<Contact>>(
          initialData: List(),
          future: contactDao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.purple));
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.data != null) {
                  final List<Contact> contacts = snapshot.data;

                  return ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final Contact contact = contacts[index];
                        return _ContactItem(contact, onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransactionForm(contact)));
                        });
                      });
                }
                break;
            }
            return Text("Unknown error");
          },
        ));
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        title: Text(contact.name),
        subtitle: Text(contact.accountNumber.toString()),
      ),
    );
  }
}
