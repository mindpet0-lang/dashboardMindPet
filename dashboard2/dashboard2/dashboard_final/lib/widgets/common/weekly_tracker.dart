import 'package:flutter/material.dart';

class WeeklyTracker extends StatelessWidget {
  const WeeklyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.favorite, color: Colors.green),
          Icon(Icons.favorite, color: Colors.green),
          Icon(Icons.favorite, color: Colors.blue),
          Icon(Icons.favorite, color: Colors.purple),
          Icon(Icons.favorite, color: Colors.green),
          Icon(Icons.favorite, color: Colors.blue),
          Icon(Icons.favorite, color: Colors.purple),
        ],
      ),
    );
  }
}