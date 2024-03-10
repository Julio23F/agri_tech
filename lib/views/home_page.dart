// import 'package:bluetooth/controllers/bluetooth_controller.dart';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final BluetoothConnection connection;
  final humidityHistory;

  HomePage({required this.connection, required this.humidityHistory});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool isWatered = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Header
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Image.asset(
                    "assets/images/ispm.png",
                    width: 55,
                ),
              ),
              SizedBox(height: 30,),

              //Title
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Agri Tech",
                        style: TextStyle(
                          fontSize: 27,
                          color: Color(0xff183f0e),
                          fontWeight: FontWeight.w700
                        ),
                    ),
                    Text(
                        "Esiia 2a",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color(0xff183f0e),
                            fontWeight: FontWeight.w700
                        ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),

              //Etat du sol
              Container(
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xfff4f8fe),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Etat satisfaisant",
                              style: TextStyle(
                                color: Color(0xff183f0e),
                                fontSize: 17,
                                  fontWeight: FontWeight.w700
                              ),
                          ),
                          Text(
                              "Actuellement, le sol est vivable pour cette agriculture",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                              ),
                          ),
                          SizedBox(height: 15,),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isWatered = !isWatered;
                              });
                              if(isWatered) {
                                sendData("on");
                              }
                              else{
                                sendData("off");
                              }

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isWatered ? Color(0xff886f72) : Color(0xFF3c9b22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isWatered ? 'Stop' : 'Arroser',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Image.asset(
                        "assets/images/representation.png",
                        width: 100,
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              //Historique
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Historique",
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: StreamBuilder<List<String>>(
                        stream: widget.humidityHistory,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Column(
                              children: snapshot.data!.map((humidity) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Humide",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff183f0e),
                                              ),
                                            ),
                                            Text(
                                              "La plante est vivable",
                                              style: TextStyle(
                                                  color: Colors.grey
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${humidity}% H",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),

                    ),
                    SizedBox(height: 10,),


                    // Container(
                    //   child: ListView.builder(
                    //     itemCount: widget.humidityHistory.length,
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         title: Text(widget.humidityHistory[index]),
                    //       );
                    //     },
                    //   ),
                    // ),



                  ],
                )
              )

            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white70,
      //   onPressed: () {
      //
      //   },
      //   child: Image.asset("assets/images/goutte.png", width: 25,),
      // ),
    );
  }

  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      widget.connection.output.add(bytes);
      await widget.connection.output.allSent;

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
