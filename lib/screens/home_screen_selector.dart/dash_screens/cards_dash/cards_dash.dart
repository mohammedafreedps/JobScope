import 'package:flutter/material.dart';
import 'package:jobscope/screens/home_screen_selector.dart/dash_screens/cards_dash/widgets/cards.dart';

class CardsDash extends StatelessWidget {
  const CardsDash({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double maxCrossAxisExtent;

    if (screenWidth < 600) {
      crossAxisCount = 1;
      maxCrossAxisExtent = screenWidth;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      crossAxisCount = 2;
      maxCrossAxisExtent = screenWidth / 2;
    } else if (screenWidth >= 1200 && screenWidth < 1500){
      crossAxisCount = 3;
      maxCrossAxisExtent = screenWidth / 3;
    }
     else {
      crossAxisCount = 4;
      maxCrossAxisExtent = screenWidth / 4;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return cards();
        },
      ),
    );
  }
}
