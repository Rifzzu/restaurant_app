import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(id, fit: BoxFit.cover, width: 90, height: 90,
                  errorBuilder: (_, __, ___) {
                return const Center(child: Icon(Icons.error));
              }),
            ),
            const SizedBox(height: 4.0),
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
