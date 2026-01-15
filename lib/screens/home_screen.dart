import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    // Static selected index (for design only)
    int selectedIndex = 0;

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
      // Static Bottom Navigation Bar (Design Only)
      bottomNavigationBar: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 28),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home Icon (Active - for design)
            _buildNavItem(
              icon: Icons.home,
              activeIcon: Icons.home,

              isActive: true, // First one is active for design
            ),

            _buildNavItem(
              icon: Icons.bookmark,
              activeIcon: Icons.bookmark,
              isActive: false,
            ),

            _buildNavItem(
              icon: Icons.heart_broken,
              activeIcon: Icons.explore,
              isActive: false,
            ),

            _buildNavItem(
              icon: Icons.menu_open_outlined,
              activeIcon: Icons.menu,

              isActive: false,
            ),
          ],
        ),
      ),
    );
  }

  // Navigation Item Builder
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    // required String label,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with active state
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue.shade100 : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? activeIcon : icon,
              color: isActive ? Colors.blue.shade800 : Colors.grey.shade600,
              size: 24,
            ),
          ),

          const SizedBox(height: 4),
        ],
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
