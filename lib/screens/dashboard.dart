import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/transaction_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("lib/assets/pinwheel.jpg"),
                // Image.network(
                //     'https://cdn.pixabay.com/photo/2019/10/15/06/03/pinwheel-4550711_960_720.jpg'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          FeatureItem(
                              name: "Transfer",
                              icon: Icons.monetization_on,
                              onClick: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactsList()))),
                          FeatureItem(
                              name: "Transaction feed",
                              icon: Icons.insert_drive_file,
                              onClick: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionsList()))),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  FeatureItem({this.name, this.icon, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            color: Theme.of(context).primaryColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon),
                  Text(name, textAlign: TextAlign.center)
                ]),
          ),
        ));
  }
}
