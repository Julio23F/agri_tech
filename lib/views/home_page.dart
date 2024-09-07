// import 'package:bluetooth/controllers/bluetooth_controller.dart';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool isWatered = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff2f2f2), Color(0xffefefef)],
          ),
        ),
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Header
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset(
                          "assets/images/ispm.png",
                          width: 55,
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                color: Color(0xff183f0e).withOpacity(0.8),
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              //Haut
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, size: 16,),
                                          Text(
                                              'Antananarivo',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff183f0e),
                                                  fontWeight: FontWeight.w700
                                              ),
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '+17°',
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: Color(0xff183f0e),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Transform.translate(
                                                offset: Offset(0, 0),
                                                child: Text(
                                                  'c',
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    color: Color(0xff183f0e),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                  Icon(
                                    Icons.cloud_outlined,
                                    size: 40,
                                  )

                                ],
                              ),
                              //Ligne
                              Divider(
                                color: Colors.grey.withOpacity(0.5),
                                thickness: 1,
                              ),

                              //bas
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Humidity",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff183f0e).withOpacity(0.6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "30 %",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff183f0e),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Précipitation",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff183f0e).withOpacity(0.6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "5.1 ml",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff183f0e),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width * 1/3,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Terre',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff183f0e),
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              'Niveau humidité',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff183f0e).withOpacity(0.5),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "30%",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff183f0e),
                                        fontWeight: FontWeight.w700
                                    ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.arrow_back_sharp,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                )

                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Title
                SizedBox(height: 20,),

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
                                isWatered ? 'Stopper' : 'Arroser',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ColorFiltered(
                        colorFilter: isWatered?ColorFilter.matrix(<double>[
                          0.9, 0.2, 0.1, 0, 0,
                          0.5, 0.3, 0.1, 0, 0,
                          0.3, 0.2, 0.1, 0, 0,
                          // Alpha channel
                          0, 0, 0, 1, 0,
                        ]):
                        ColorFilter.matrix(<double>[
                          0.8, 0.3, 0.2, 0, 0,
                          0.4, 0.6, 0.2, 0, 0,
                          0.3, 0.2, 0.2, 0, 0,
                          0, 0, 0, 1, 0,
                        ]),
                        child: Image.asset('assets/images/representation.png'),
                      ),
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
      ),
    );
  }

  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);

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
