import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PageB extends StatefulWidget {
  final BluetoothConnection connection;

  PageB({required this.connection});

  @override
  State<PageB> createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connexion:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.connection.toString(), // Utiliser widget.connection pour accéder à la connexion
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: Text("ON"),
              onPressed: () {
                sendData("on");
              },
            ),
            ElevatedButton(
              child: Text("OFF"),
              onPressed: () {
                sendData("off");
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      widget.connection.output.add(bytes); // Utiliser widget.connection pour accéder à la connexion
      await widget.connection.output.allSent; // Utiliser widget.connection pour accéder à la connexion
      // Handle data sent successfully
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("On et Off"),
          );
        },
      );
    }
  }
}
