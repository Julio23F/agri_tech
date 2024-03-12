import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:bluetooth/views/controll_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../BlueConnectionManager.dart';



class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final BlueConnectionManager _connectionManager = BlueConnectionManager();
  late BluetoothConnection connection;

  final String targetMacAddress = "00:23:02:34:DE:91";

  bool isConnected = false;

  final List<String> _humidityHistory = [];
  final StreamController<List<String>> _humidityStreamController = StreamController<List<String>>.broadcast();



  // void connectToDevice() async {
  //   try {
  //     BluetoothConnection.toAddress(targetMacAddress).then((_connection) {
  //       print('Connected to device');
  //       _connection.input!.listen((Uint8List data) {
  //         String newData = utf8.decode(data);
  //         _humidityHistory.add(newData);
  //         _humidityStreamController.add(_humidityHistory);
  //       });
  //       setState(() {
  //         connection = _connection;
  //         isConnected = true;
  //       });
  //
  //       // Rediriger vers ControllPage
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           // builder: (context) => HomePage(connection: connection, humidityHistory: _humidityStreamController.stream),
  //           builder: (context) => ControllPage(connection: connection, humidityHistory: _humidityStreamController.stream),
  //         ),
  //       );
  //     });
  //   } catch (error) {
  //     print('Cannot connect, exception occurred');
  //     print(error);
  //   }
  // }
  void connectToDevice() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      BluetoothConnection.toAddress(targetMacAddress).then((_connection) {
        print('Connected to device');
        Navigator.pop(context);
        _connection.input!.listen((Uint8List data) {
          String newData = utf8.decode(data);
          _humidityHistory.add(newData);
          _humidityStreamController.add(_humidityHistory);

          // String newData = utf8.decode(data);
          // _humidityHistory.add(newData);
          // _humidityStreamController.add(_humidityHistory.map((humidity) => double.parse(humidity).toStringAsFixed(2)).toList());

        });
        setState(() {
          connection = _connection;
          isConnected = true;
        });

        // Rediriger vers ControllPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ControllPage(connection: connection, humidityHistory: _humidityStreamController.stream),
          ),
        );
      }).catchError((error) {
        print('Cannot connect, exception occurred: $error');
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur de connexion'),
              content: Text('Impossible de se connecter à cette appareil.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    } catch (error) {
      print('Cannot connect, exception occurred: $error');
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur de connexion'),
            content: Text('Impossible de se connecter à cette appareil.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
  void initState() {
    super.initState();
    _connectionManager.init();

  }

  // Future<void> _loadDevices() async {
  //   List<BluetoothDevice> devices =
  //   await FlutterBluetoothSerial.instance.getBondedDevices();
  //
  //   setState(() {
  //     _devices = devices;
  //   });
  // }


  // Future<void> connect(String address, BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Connexion en cours"),
  //         content: Container(child: CircularProgressIndicator()),
  //       );
  //     },
  //   );
  //
  //   try {
  //     var connection = await BluetoothConnection.toAddress(address);
  //     Navigator.pop(context); // Fermer le dialogue de chargement
  //     print("Connecté à l'appareil");
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Row(
  //             children: [
  //               Icon(Icons.check_circle, color: Colors.green),
  //               SizedBox(width: 10),
  //               Text("Connexion réussie"),
  //             ],
  //           ),
  //           content: Text(
  //             "La connexion a été établie avec succès.",
  //             style: TextStyle(
  //                 color: Colors.grey
  //             ),
  //
  //           ),
  //         );
  //       },
  //     );
  //
  //
  //     //Rediriger vers la page Controller
  //     Timer(Duration(seconds: 3), () {
  //       Navigator.of(context).pop(); // Fermer le dialogue de chargement
  //       print("Connecté à l'appareil");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => BlueController()),
  //       );
  //     });
  //
  //     connection.input!.listen((Uint8List data) {
  //       print('Data incoming: ${ascii.decode(data)}');
  //       connection.output.add(data); // Sending data
  //
  //       if (ascii.decode(data).contains('!')) {
  //         connection.finish(); // Closing connection
  //         print('Déconnexion');
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Row(
  //                 children: [
  //                   Icon(Icons.error, color: Colors.red),
  //                   SizedBox(width: 10),
  //                   Text("Déconnexion"),
  //                 ],
  //               ),
  //               content: Text(
  //                 "La connexion a été interrompue",
  //                 style: TextStyle(
  //                     color: Colors.grey
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       }
  //     }).onDone(() {
  //       print('Déconnecté par demande à distance');
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Row(
  //               children: [
  //                 Icon(Icons.error, color: Colors.red), // Icône de danger
  //                 SizedBox(width: 10), // Espacement entre l'icône et le titre
  //                 Text("Erreur"), // Titre de la boîte de dialogue
  //               ],
  //             ),
  //             content: Text(
  //               "Déconnecté par demande à distance",
  //               style: TextStyle(
  //                   color: Colors.grey
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     });
  //   } catch (exception) {
  //     Navigator.pop(context);// Fermer le dialogue de chargement
  //     print('La connexion a échoué');
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Row(
  //             children: [
  //               Icon(Icons.error, color: Colors.red), // Icône de danger
  //               SizedBox(width: 10), // Espacement entre l'icône et le titre
  //               Text("Erreur"), // Titre de la boîte de dialogue
  //             ],
  //           ),
  //           content: Text(
  //             "La connexion à l'appareil a échoué",
  //             style: TextStyle(
  //                 color: Colors.grey
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }


  final List<String> icons = [
    'sol',
    'plante',
    'eau',
    'vent',
  ];
  final List<String> iconsDeux = [
    'phone',
    'agriculture',
    'avatar',
    'soleil',
    'terre',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 55),
            height: MediaQuery.of(context).size.height * 3 / 5,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffdcc0e7), Colors.white70],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(100),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white70,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(47),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white70,
                          width: 2,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Color(0xfff6f1f7),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/eart.png',
                          // width: MediaQuery.of(context).size.width ,
                        ),
                      ),
                    ),
                  ),
                ),
                for (int i = 0; i < 4; i++)
                  Center(
                    child: Transform.translate(
                      offset: Offset(
                        95 * cos(2 * pi * i / 4 - pi / 8),
                        95 * sin(2 * pi * i / 4 - pi / 8),
                      ),
                      child: Image.asset(
                        'assets/images/${icons[i]}.png',
                        width: 40,
                      ),
                    ),
                  ),
                for (int i = 0; i < 5; i++)
                  Center(
                    child: Transform.translate(
                      offset: Offset(
                        190 * cos(2 * pi * i / 5 + pi / 4),
                        190 * sin(2 * pi * i / 5 + pi / 4),
                      ),
                      child: Image.asset(
                        "assets/images/${iconsDeux[i]}.png",
                        width: 50,
                      ),
                    ),
                  ),


              ],
            ),

          ),


          // Commencer
          Container(
            height: MediaQuery.of(context).size.height * 2 / 5,
            color: Colors.white70,
            width: double.infinity,
            padding: EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Text(
                    "Agri Tech",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                    ),
                ),
                SizedBox(height: 10,),
                Text(
                    "Small Actions for",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w400
                    ),
                ),
                Text(
                    "Better results.",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple
                    ),
                ),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.deepPurple, Colors.blue],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      connectToDevice();
                    },
                    child: Text(
                      'Scanner',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
