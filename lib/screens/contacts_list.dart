import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contacts.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Transfer")),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _loadData(dependencies.contactDao),
        // widget.contactDao.findAll(),
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
                      return ContactItem(contact, onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TransactionForm(contact)));
                      });
                    });
              }
              break;
          }
          return Text("Unknown error");
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).backgroundColor,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactForm()));
            _loadData(dependencies.contactDao);
          }),
    );
  }
}

Future<List<Contact>> _loadData(contactDao) async {
  return await contactDao.findAll();
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  ContactItem(this.contact, {@required this.onClick});

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
