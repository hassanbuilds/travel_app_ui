import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Hello, Hassan ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Welcome to Trip Glide",
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 15),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage("images/profile_pic.jpg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar with icon on right
            Container(
              width: 375,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 35),
                  const SizedBox(width: 8),
                  const Text(
                    "Search",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                  const Spacer(), // ← This pushes the icon to the right
                  Icon(Icons.filter_list, color: Colors.black, size: 35),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Categories
            const Text(
              "Select your next trip",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategory("Asia", true),
                  _buildCategory("Europe", false),
                  _buildCategory("America", false),
                  _buildCategory("Canada", false),
                  _buildCategory("Pakistan", false),
                  _buildCategory("London", false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Destination Card (Fake for now)
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text("Destination Card Here")),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCategory(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
