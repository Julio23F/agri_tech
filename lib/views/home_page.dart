// import 'package:bluetooth/controllers/bluetooth_controller.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatefulWidget {
  // final BluetoothConnection connection;
  // final humidityHistory;
  //
  // HomePage({required this.connection, required this.humidityHistory});
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool isWatered = false;
  String temperature = '';
  String weatherDescription = '';
  String humidity = '';
  String etat = '';
  String precipitation = '';


  Future<void> fetchWeather() async {
    String apiKey = 'e9f76dd24e763948b483fc267eb57c4e';
    double latitude = -18.8792;
    double longitude = 47.5079;

    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temperature = data['main']['temp'].toString() + '°';
          weatherDescription = data['weather'][0]['description'];
          etat = data['weather'][0]['main'].toLowerCase();
          humidity = data['main']['humidity'].toString() + ' %';
          precipitation = data['rain'] != null ? data['rain']['1h'].toString() + ' mm' : '0 mm';
        });
      } else {
        print('Erreur lors de la récupération des données météo : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        // color: Colors.white.withOpacity(0.3),
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white.withOpacity(0.1), Color(0xffefefef).withOpacity(0.1)],
            ),
          ),*/
          //color: Color(0xffefefef).withOpacity(0.1),
          color: Colors.white,

        height: MediaQuery.sizeOf(context).height,
        child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: false,
                floating: true,
                delegate: SliverAppBarDelegate(
                  minHeight: 120.0,
                  maxHeight: 120.0,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
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
                                          fontSize: 24,
                                          color: Color(0xff183f0e),
                                          fontWeight: FontWeight.w700,
                                          height: 0.9,
                                      ),
                                    ),
                                    Text(
                                      "Esiia 2a",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
                )
              ),
              SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SliverAppBarDelegate(
                minHeight: 325.0,
                maxHeight: 325.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffefefef),
                        width: 2, 
                      ),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Météo
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.1),
                                      width: 1,
                                    ),
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
                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: temperature.isNotEmpty ? temperature : '0°',
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
                                                        ),],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            (etat == "clouds")?
                                            "assets/icons/nuage.png":
                                            (etat == "rain")?
                                            "assets/icons/pluie.png":
                                            "assets/icons/soleil.png",
                                            width: 45,
                                          ),
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
                                                humidity.isNotEmpty ? humidity : '',
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
                                                precipitation.isNotEmpty ? precipitation : '',
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
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sol',
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

                        //Etat du sol
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                          // sendData("on");
                                        }
                                        else{
                                          // sendData("off");
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
                                colorFilter: !isWatered?ColorFilter.matrix(<double>[
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
                      ],
                    ),
                )
                )
              ),
              SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    //Historique
                    return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // for(int i=0; i<15; i++)
                            //   Container(
                            //     width: MediaQuery.of(context).size.width,
                            //     margin: EdgeInsets.only(top: 10),
                            //     padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       border: Border.all(
                            //         color: Colors.grey.withOpacity(0.1),
                            //         width: 2,
                            //       ),
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     child: Text("essais"),
                            //   )
                            // Container(
                            //   child: StreamBuilder<List<String>>(
                            //     stream: widget.humidityHistory,
                            //     builder: (context, snapshot) {
                            //       if (snapshot.connectionState == ConnectionState.waiting) {
                            //         return CircularProgressIndicator();
                            //       } else if (snapshot.hasError) {
                            //         return Text('Error: ${snapshot.error}');
                            //       } else {
                            //         return Column(
                            //           children: snapshot.data!.map((humidity) {
                            //             return Container(
                            //               margin: EdgeInsets.only(bottom: 15),
                            //               child: Row(
                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Expanded(
                            //                     child: Column(
                            //                       crossAxisAlignment: CrossAxisAlignment.start,
                            //                       children: [
                            //                         Text(
                            //                           "Humide",
                            //                           style: TextStyle(
                            //                             fontWeight: FontWeight.w800,
                            //                             color: Color(0xff183f0e),
                            //                           ),
                            //                         ),
                            //                         Text(
                            //                           "La plante est vivable",
                            //                           style: TextStyle(
                            //                               color: Colors.grey
                            //                           ),
                            //                         )
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   Text(
                            //                     "${humidity}% H",
                            //                     style: TextStyle(
                            //                         color: Colors.blue,
                            //                         fontWeight: FontWeight.w700
                            //                     ),
                            //                   )
                            //                 ],
                            //               ),
                            //             );
                            //           }).toList(),
                            //         );
                            //       }
                            //     },
                            //   ),
                            //
                            // ),


                          ],
                        )
                    );
                  }
                )
              ),

            ]
        )

      ),
    );
  }

  // Future<void> sendData(String data) async {
  //   data = data.trim();
  //   try {
  //     List<int> list = data.codeUnits;
  //     Uint8List bytes = Uint8List.fromList(list);
  //     widget.connection.output.add(bytes);
  //     await widget.connection.output.allSent;
  //
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Erreur"),
  //           content: Text("On et Off"),
  //         );
  //       },
  //     );
  //   }
  // }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}