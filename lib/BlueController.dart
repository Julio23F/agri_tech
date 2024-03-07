import 'dart:async';
import 'package:bluetooth/page_deux.dart';
import 'package:flutter/material.dart';
import 'BlueConnectionManager.dart';

class BlueController extends StatefulWidget {
  const BlueController({Key? key});

  @override
  State<BlueController> createState() => _BlueControllerState();
}

class _BlueControllerState extends State<BlueController> {
  final BlueConnectionManager _connectionManager = BlueConnectionManager();

  @override
  void initState() {
    super.initState();
    _connectionManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 75.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Première page"),
              SizedBox(height: 25,),
              const Text("MAC Address: 00:23:02:34:DE:91"),
              ElevatedButton(
                child: Text("Connect"),
                onPressed: () {
                  _connectionManager.connect("00:23:02:34:DE:91");
                },
              ),
              SizedBox(height: 30.0,),
              ElevatedButton(
                child: Text("OPEN"),
                onPressed: () {
                  _connectionManager.sendData("on");
                },
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                child: Text("Allumer"),
                onPressed: () {
                  _connectionManager.allumer("on");
                },
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                child: Text("Envoyer"),
                onPressed: () {
                  _connectionManager.envoyer("on");
                },
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                child: Text("CLOSE"),
                onPressed: () {
                  _connectionManager.sendData("off");
                },
              ),
              SizedBox(height: 30.0,),
              ElevatedButton(
                child: Text("Deuxème page"),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DeuxemePage()),
                  // );
                },
              ),
              SizedBox(height: 30.0,),
              Expanded(
                child: StreamBuilder<List<String>>(
                  stream: _connectionManager.humidityStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index]),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JulioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Julio Page"),
    );
  }
}
