import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false; // Track heart icon state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use Stack so the white container can sit "on top" of the image
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE
          Image.network(
            widget.destination['imageUrl'] as String? ??
                'https://via.placeholder.com/400',
            height:
                400, // Make this slightly taller than where the white box starts
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // 2. THE WHITE CURVED SECTION
          Positioned(
            top: 280, // This is the distance from the top of the screen
            left: 0,
            right: 0,
            bottom: 0, // This ensures it fills the rest of the screen
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0), // The curve
                  topRight: Radius.circular(40.0), // The curve
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: SingleChildScrollView(
                  // Allows the content inside to scroll
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The little grey handle bar at the top
                      Center(
                        child: Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Add your Title, Description, and Tours here
                      Text(
                        widget.destination['name'] ?? "Rio de Janeiro",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // ... rest of your UI elements
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          widget.destination['imageUrl'] as String? ??
                              'https://en.wikipedia.org/wiki/File:Flag_of_Brazil.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. TOP BUTTONS (Keep these at the bottom of the Stack so they stay on top)
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.7),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.7),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () => setState(() => isFavorite = !isFavorite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
