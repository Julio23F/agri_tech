import 'package:bluetooth/controllers/bluetooth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3c9b22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Bordure du bouton
                              ),
                            ),
                            child: Text(
                                'Arroser',
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
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Color(0xfff4f8fe),
                          borderRadius: BorderRadius.circular(7)
                      ),
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
                              "45% H",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700
                              ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              )

            ],
          ),
        ),
      )
    );
  }
}
