import 'dart:math';

import 'package:flutter/material.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  final List<String> icons = [
    'sol',
    'plante',
    'eau',
    'vent',
  ];
  final List<String> iconsDeux = [
    'phone',
    'terre',
    'agriculture',
    'soleil',
    'terre',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.purple[100],
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color(0xfff6f1f7),
                  shape: BoxShape.circle, // Pour créer un cercle
                  border: Border.all(
                    color: Colors.white, // Couleur de la bordure
                    width: 3, // Largeur de la bordure
                  ),
                ),
                child: Image.asset(
                  'assets/images/eart.png',
                  width: 100, // Ajustez la taille de l'image selon vos besoins
                ),
              ),
            ),
            for (int i = 0; i < 8; i++)
              Center(
                child: Transform.translate(
                  offset: Offset(
                    100 * cos(2 * pi * i / 8), // Rayon * cos(angle)
                    100 * sin(2 * pi * i / 8), // Rayon * sin(angle)
                  ),
                  child: Image.asset(
                    'assets/images/icon.png', // Chemin de votre icône
                    width: 40, // Taille de votre icône
                  ),
                ),
              ),
            for (int i = 0; i < 5; i++)
              Center(
                child: Transform.translate(
                  offset: Offset(
                    210 * cos(2 * pi * i / 5 + pi / 4), // Rayon * cos(angle) avec un décalage
                    210 * sin(2 * pi * i / 5 + pi / 4), // Rayon * sin(angle) avec un décalage
                  ),
                  child: Image.asset(
                    "assets/images/${iconsDeux[i]}.png", // Chemin de votre icône
                    width: 70, // Taille de votre icône
                  ),
                ),
              ),
          ],
        ),

      ),
    );
  }
}
