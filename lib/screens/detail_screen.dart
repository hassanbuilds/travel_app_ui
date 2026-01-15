import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> destination;

  const DetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                destination['imageUrl'] as String? ??
                    'https://via.placeholder.com/400', // fallback
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // ... rest of your code
            ],
          ),
        ],
      ),
    );
  }
}
