import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircularProgressIndicator(backgroundColor: Colors.purple),
          Text(
            "Loading...",
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }
}
