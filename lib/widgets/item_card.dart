
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String image;
  final Function open;
  const ItemCard(this.title, this.image, this.open, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: () {
          open();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image(
                image: AssetImage(image),
                height: 150,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
