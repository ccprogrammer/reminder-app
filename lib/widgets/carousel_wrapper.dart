import 'package:flutter/material.dart';
import 'package:reminder_app/widgets/carousel_card.dart';

class CarouselWrapper extends StatelessWidget {
  const CarouselWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CarouselCard(title: "Beach", image: "assets/beach.jpg"),
          CarouselCard(title: "Mountain", image: "assets/mountain.jpg"),
          CarouselCard(title: "City", image: "assets/city.jpg"),
        ],
      ),
    );
  }
}
