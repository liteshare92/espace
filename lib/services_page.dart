import 'package:espace/build_appbart.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Services', context), // Change 'Map' to 'Contact' or 'Produits' as needed
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Container(
            color: index % 2 == 0 ? Colors.white : Colors.grey[200],
            child: ListTile(
              leading: Image.asset(
                service.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(service.name),
              subtitle: Text(service.description),
              trailing: Text('${service.price.toStringAsFixed(2)} F'),
            ),
          );
        },
      ),
    );
  }
}

class Service {
  final String name;
  final String description;
  final double price;
  final String imagePath;

  Service(this.name, this.description, this.price, this.imagePath);
}

final services = [
  Service('Pressing Boubou 1 pc', 'Par pièce', 1000.00, 'assets/images/boubou_1pc.png'),
  Service('Pressing Boubou 2 pc', 'Par pièce', 2000.00, 'assets/images/Boubou_2pc.png'),
  Service('Pressing Boubou 3 pc', 'Par pièce', 3000.00, 'assets/images/Boubou_3pc.png'),
  Service('Lavage', 'Par kg', 500.00, 'assets/images/wash.png'),
  Service('Lavage et séchage', 'Par kg', 1000.00, 'assets/images/wash_fold.png'),
  Service('Lavage - Chemise', 'Par pièce', 500.00, 'assets/images/shirt.png'),
  Service('Lavage - Lacoste', 'Par pièce', 500.00, 'assets/images/polo.png'),
  Service('Lavage - Pantalon', 'Par pièce', 700.00, 'assets/images/pants.png'),
  Service('Lavage - Costume', 'Costume 2 pièces', 3500.00, 'assets/images/suit.png'),
  Service('Lavage - Robe', 'Robe simple', 900.00, 'assets/images/dress.png'),
  Service('Service de Repassage', 'Par pièce', 200.00, 'assets/images/iron.png'),
  Service('Literie - Simple', 'Lavage et pliage', 1500.00, 'assets/images/bedding_single.png'),
  Service('Literie - Double/Queen', 'Lavage et pliage', 2000.00, 'assets/images/bedding_double.png'),
  Service('Rideaux', 'Par panneau', 800.00, 'assets/images/curtains.png'),
   Service('Lavage - Couverture', 'Par pièce', 2000.00, 'assets/images/couverture.png'),
  Service('Retouches', 'À partir de', 500.00, 'assets/images/alterations.png'),
];
