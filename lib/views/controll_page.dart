import 'package:bluetooth/views/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'home_page.dart';

class ControllPage extends StatefulWidget {
  final BluetoothConnection connection;
  final humidityHistory;
  ControllPage({required this.connection, required this.humidityHistory});

  @override
  State<ControllPage> createState() => _ControllPageState();
}

class _ControllPageState extends State<ControllPage> {
  int _currentIndex = 0;
  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: [
            // HomePage(connection: widget.connection, humidityHistory: widget.humidityHistory),
            // SettingPage(connection: widget.connection, humidityHistory: widget.humidityHistory),
          ][_currentIndex],
        ),
        BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          selectedItemColor: Colors.deepOrange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Paramètre',
            ),
          ],
        ),
      ],
    );
  }
}
