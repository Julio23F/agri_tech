import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';


class BlueController extends StatefulWidget {
  const BlueController({super.key});

  @override
  State<BlueController> createState() => _BlueControllerState();
}

class _BlueControllerState extends State<BlueController> {

  List<BluetoothDevice> _devices = [];
  late BluetoothConnection connection;
  String adr="00:23:02:34:DE:91"; // my bluetooth device MAC Adres

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();

    setState(() {   _devices = devices;    });
  }
//----------------------------
  Future<void> sendData(String data)  async {

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
        title: const Text("Bluetooth Single LED Control"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("MAC Adress: 00:23:02:34:DE:91"),

            ElevatedButton(child:Text("Connect"),onPressed: () {
              connect(adr);

            },),
            SizedBox(height: 30.0,),

            ElevatedButton(child:Text(" OPEN "),onPressed: () {
              sendData("on");

            },),

            SizedBox(height: 10.0,),
            ElevatedButton(child:Text("CLOSE"),onPressed: () {
              sendData("off");

            },),
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
        // Data entry point
        // durum=ascii.decode(data);
      });
    } catch (exception) {
      // Afficher une boîte de dialogue avec le message d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur de connexion"),
            content: Text("La connexion a échoué."),
          );
        },
      );
    }
  }
}
