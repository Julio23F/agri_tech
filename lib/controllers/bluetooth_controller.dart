import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlueController extends StatefulWidget {
  const BlueController({Key? key});

  @override
  State<BlueController> createState() => _BlueControllerState();
}

class _BlueControllerState extends State<BlueController> {
  List<BluetoothDevice> _devices = [];
  late BluetoothConnection connection;
  String adr = "00:23:02:34:DE:91"; // my bluetooth device MAC Address
  String humidityData = 'No data';

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    List<BluetoothDevice> devices =
    await FlutterBluetoothSerial.instance.getBondedDevices();

    setState(() {
      _devices = devices;
    });
  }

  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      connection.output.add(bytes);
      await connection.output.allSent;
      if (kDebugMode) {
        // print('Data sent successfully');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth Humidity Monitor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("MAC Address: 00:23:02:34:DE:91"),
            ElevatedButton(
              child: Text("Connect"),
              onPressed: () {
                connect(adr);
              },
            ),
            SizedBox(height: 30.0,),
            ElevatedButton(
              child: Text("OPEN"),
              onPressed: () {
                sendData("on");
              },
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              child: Text("CLOSE"),
              onPressed: () {
                sendData("off");
              },
            ),
            SizedBox(height: 30.0,),
            Text("Humidity: $humidityData"),
          ],
        ),
      ),
    );
  }

  Future<void> connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      sendData('111');
      connection.input!.listen((Uint8List data) {
        String newData = utf8.decode(data);
        setState(() {
          humidityData = newData;
        });
      });
    } catch (exception) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Connection Error"),
            content: Text("Connection failed."),
          );
        },
      );
    }
  }
}
