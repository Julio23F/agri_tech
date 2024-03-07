import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:bluetooth/page_trois.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  late BluetoothConnection connection;
  final String targetMacAddress = "00:23:02:34:DE:91";
  bool isConnected = false;

  void connectToDevice() async {
    try {
      BluetoothConnection.toAddress(targetMacAddress).then((_connection) {
        print('Connected to device');
        setState(() {
          connection = _connection;
          isConnected = true;
        });

        // Redirect to another page or perform actions after successful connection
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageB(connection: connection),
          ),
        );
      });
    } catch (error) {
      print('Cannot connect, exception occurred');
      print(error);
    }
  }

  void sendData(String data) async {
    data = data.trim();
    if (connection != null && connection.isConnected) {
      connection.output.add(utf8.encode(data));
      await connection.output.allSent;
      print('Data sent: $data');
    } else {
      print('Not connected to any device');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Connection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isConnected ? 'Connected' : 'Disconnected',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                connectToDevice();
              },
              child: Text('Connect to Bluetooth'),
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

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }
}
