import 'package:bluetooth/views/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';


class SettingPage extends StatefulWidget {
  final BluetoothConnection connection;
  final humidityHistory;

  SettingPage({required this.connection, required this.humidityHistory});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _switchValue = false;

  void disconnectBluetooth() async {
    if (widget.connection != null) {
      try {
        await widget.connection.close();
        // La connexion Bluetooth est fermée avec succès
        // setState(() {
        //   widget.connection = null;
        // });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartPage(),
          ),
        );
      } catch (e) {
        // Gérer les erreurs de déconnexion
        print('Erreur lors de la déconnexion Bluetooth: $e');
      }
    } else {
      // Aucune connexion Bluetooth à fermer
      print('Aucune connexion Bluetooth à fermer.');
    }
  }

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Image.asset(
                      "assets/images/ispm.png",
                      width: 90,
                    ),
                    SizedBox(height: 15,),
                    Text("Adresse Mac",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0c3141)
                      ),
                    ),
                    Text(
                      "00:23:02:34:DE:91",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                              backgroundColor: MaterialStatePropertyAll(Color(0xff409bfc))
                          ),
                          onPressed: (){

                          },
                          child: Text(
                              "Agri Tech",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              )
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

              // Info compte
              Container(
                margin: EdgeInsets.only(bottom: 7),
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 18),
                        child: Icon(
                          Icons.comment_outlined,
                          size: 25,
                          color: Color(0xff409bfc),
                        )
                    ),
                    Text(
                      "Mon compte",
                      style: TextStyle(
                          color: Color(0xff0c3141),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Spacer(),
                    Container(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )
                    ),
                  ],
                ),
              ),


              // Info concernant l'application
              Container(
                margin: EdgeInsets.only(bottom: 7),
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 18),
                        child: Icon(
                          Icons.info_outline,
                          size: 25,
                          color: Color(0xff409bfc),
                        )
                    ),
                    Text(
                      "À propos",
                      style: TextStyle(
                          color: Color(0xff0c3141),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Spacer(),
                    Container(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )
                    ),
                  ],
                ),
              ),

              // Mode Dark
              Container(
                margin: EdgeInsets.only(bottom: 7),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 18),
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          size: 25,
                          color: Color(0xff409bfc),
                        )
                    ),
                    Text(
                      "Dark Mode",
                      style: TextStyle(
                          color: Color(0xff0c3141),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: _switchValue,
                      onChanged: (newValue) {
                        setState(() {
                          _switchValue = newValue;
                        });
                      },
                      activeColor: Colors.blue[40],
                      inactiveTrackColor: Colors.grey[40],
                    ),
                  ],
                ),
              ),

              // Déconexion
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Voulez-vous réellement vous déconnecter ?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Fermer le popup
                              Navigator.of(context).pop();
                            },
                            child: Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () {
                              disconnectBluetooth();

                            },
                            child: Text('Confirmer'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 18),
                          child: Icon(
                            Icons.logout_outlined,
                            size: 25,
                            color: Color(0xff409bfc),
                          )
                      ),
                      Text(
                        "Déconnexion",
                        style: TextStyle(
                            color: Color(0xff0c3141),
                            fontWeight: FontWeight.w500
                        ),
                      ),

                      Spacer(),
                      Container(
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          )
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        )
    );
  }
}
