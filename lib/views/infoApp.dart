import 'package:flutter/material.dart';

class InfoApp extends StatefulWidget {
  const InfoApp({super.key});

  @override
  State<InfoApp> createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Comment utiliser l'application AgriTech",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Découvrez les fonctionnalités de l'application grâce à ces informations.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),

            // HomePage
            const InfoSection(
                title: 'Page d\'accueil',
                icon: Icons.home,
                content: [
                  "Consultez la météo actuelle de votre terrain pour prendre des décisions éclairées sur les actions à entreprendre.",
                  "Vous pouvez ajuster l'arrosage ou arrêter le flux d'eau selon les besoins. De plus, vous recevez des mises à jour en temps réel sur l'état du sol.",
                ],
                page: "Home"
            ),


            // Paramètres
            const InfoSection(
                title: 'Paramètres',
                icon: Icons.settings,
                content: [
                  "Découvrez comment utiliser l'application grâce aux guides fournis.",
                  "Vous pouvez également vous déconnecter ici pour rompre la connexion entre votre appareil et le module d'arrosage.",
                ],
                page: "Paramètre"
            ),
          ],
        ),
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> content;
  final String page;


  const InfoSection({super.key, 
    required this.title,
    required this.icon,
    required this.content,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Color(0xfffcfcfc),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content
                .map((item) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff0c3141),
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ))
                .toList(),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xff8463BE),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              Text(
                page,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
