// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar buildAppBar(String pageTitle ,BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Espace Beeggee'), // Consistent app name
        Text(pageTitle), // Unique page title
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.help),
        tooltip: 'À propos',
        onPressed: () => _showHelpDialog(
            context), // Appel de la fonction pour afficher le dialog
      ),
      IconButton(
        icon: const Icon(Icons.exit_to_app),
        tooltip: 'Quitter',
        onPressed: () { SystemNavigator.pop();},
      ), //IconButton
    ], //<Widget>[]
  //  backgroundColor: Colors.greenAccent[400],
    elevation: 50.0,
  );
}

void _showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('À propos de cette application'),
        content: const Text(
          'Nom de l\'application : Espace Beeggee\n'
          'Version : 1.0.0\n'
          'Auteur: Khaly Dramé\n'
          'Contact: khaly.drame@gmail.com',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le dialog
            },
            child: const Text('Fermer'),
          ),
        ],
      );
    },
  );
}
