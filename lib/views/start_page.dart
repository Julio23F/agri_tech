import 'package:flutter/material.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
                child: Image.asset(
                    'assets/images/eart.png',
                    width: 85,
                )
            )
          ],
        ),
      ),
    );
  }
}
