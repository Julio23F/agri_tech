import 'dart:async';
import 'package:bluetooth/BlueController.dart';
import 'package:bluetooth/page_deux.dart';
// import 'package:bluetooth/controllers/bluetooth_controller.dart';
import 'package:bluetooth/views/home_page.dart';
import 'package:bluetooth/views/start_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: BluetoothScreen()
    );
  }

}
