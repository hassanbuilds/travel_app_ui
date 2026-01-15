import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

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
                "Hello, Vanessa ",
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 15),
              child: SingleChildScrollView(
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
            ),

            const SizedBox(height: 20),

            CarouselSlider(
              items: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 89, 87, 86),
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 1, 0),
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ],
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 1.8,
                initialPage: 2,
                height: 380,
              ),
            ),
          ],
        ),
      ),
      // Final Corrected Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 28, left: 43, right: 43),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home (Active)
            _buildNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              isActive: true,
            ),

            // Book
            _buildNavItem(
              icon: Icons.bookmark_border,
              activeIcon: Icons.bookmark,
              isActive: false,
            ),

            // Explore
            _buildNavItem(
              icon: Icons.heart_broken_rounded,
              activeIcon: Icons.explore,
              isActive: false,
            ),

            // Menu
            _buildNavItem(
              icon: Icons.menu_outlined,
              activeIcon: Icons.menu,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }

  // Fixed Navigation Item Builder
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required bool isActive,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isActive ? activeIcon : icon,
        color: isActive
            ? Colors.black
            : Colors.grey.shade400, // Silver when inactive
        size: 24,
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
