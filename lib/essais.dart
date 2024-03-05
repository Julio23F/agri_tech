import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothPage(),
    );
  }
}

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  late BluetoothConnection connection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: _connectBluetooth,
              child: Text('Connect to Bluetooth'),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: connection.input,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Received: ${String.fromCharCodes(snapshot.data as Iterable<int>)}');
                } else {
                  return Text('Waiting for data...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _connectBluetooth() async {
    BluetoothDevice selectedDevice = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BluetoothDeviceListPage(),
      ),
    );

    if (selectedDevice != null) {
      await BluetoothConnection.toAddress(selectedDevice.address).then((value) {
        setState(() {
          connection = value;
        });
      });
    }
  }
}

class BluetoothDeviceListPage extends StatefulWidget {
  @override
  _BluetoothDeviceListPageState createState() => _BluetoothDeviceListPageState();
}

class _BluetoothDeviceListPageState extends State<BluetoothDeviceListPage> {
  List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    super.initState();
    _getPairedDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Bluetooth Device'),
      ),
      body: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_devicesList[index].name.toString()),
            subtitle: Text(_devicesList[index].address),
            onTap: () {
              Navigator.of(context).pop(_devicesList[index]);
            },
          );
        },
      ),
    );
  }

  void _getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      List<BluetoothDevice> bondedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();
      devices.addAll(bondedDevices);
    } catch (e) {
      print(e);
    }

    setState(() {
      _devicesList = devices;
    });
  }
}
