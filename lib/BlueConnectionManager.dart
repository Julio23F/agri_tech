import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlueConnectionManager {
  final List<String> _humidityHistory = [];
  final StreamController<List<String>> _humidityStreamController =
  StreamController<List<String>>.broadcast();

  late BluetoothConnection _connection;
  late BluetoothConnection _envo;

  void init() async {
    List<BluetoothDevice> devices =
    await FlutterBluetoothSerial.instance.getBondedDevices();
  }

  Future<void> connect(String address) async {
    try {
      _connection = await BluetoothConnection.toAddress(address);
      AlertDialog(
        title: Text("Succès"),
        content: Text("${_connection}"),
      );
      sendData('111');
      _connection.input!.listen((Uint8List data) {
        String newData = utf8.decode(data);
        _humidityHistory.add(newData);
        _humidityStreamController.add(_humidityHistory);
      });
    } catch (exception) {
      AlertDialog(
        title: Text("Erreur"),
        content: Text("Lors de la connexion"),
      );
    }
  }

  Future<void> allumer(String data) async {
    data = data.trim();
    try {
      _connection = await BluetoothConnection.toAddress("00:23:02:34:DE:91");
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      _connection.output.add(bytes);
      await _connection.output.allSent;
    } catch (e) {
        AlertDialog(
          title: Text("Erreur"),
          content: Text("Allumer"),
        );
    }
  }

  Future<void> envoyer(String data) async {
    data = data.trim();
    try {
      _envo = await BluetoothConnection.toAddress("00:23:02:34:DE:91");
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      _envo.output.add(bytes);
      await _envo.output.allSent;
    } catch (e) {
      AlertDialog(
        title: Text("Erreur"),
        content: Text("Envoyer"),
      );
    }
  }

  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      _connection.output.add(bytes);
      await _connection.output.allSent;
    } catch (e) {
        AlertDialog(
          title: Text("Erreur"),
          content: Text("On et Off"),
        );
    }
  }


  Stream<List<String>> get humidityStream => _humidityStreamController.stream;
}
