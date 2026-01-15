import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  // State for liked cards
  final Map<String, bool> likedCards = {
    "Brazil": false,
    "Japan": false,
    "France": false,
  };

  // State for selected category
  int selectedCategoryIndex = 0;

  // Categories list
  final List<String> categories = [
    "Asia",
    "Europe",
    "South America",
    "North Korea",
    "Africa",
  ];

  // Data for carousel items
  final List<Map<String, dynamic>> destinations = [
    {
      'title': 'Brazil',
      'subtitle': 'Rio de Janeiro',
      'rating': 5.0,
      'reviews': 143,
      'imageUrl':
          'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Japan',
      'subtitle': 'Tokyo',
      'rating': 4.8,
      'reviews': 287,
      'imageUrl':
          'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'France',
      'subtitle': 'Paris',
      'rating': 4.9,
      'reviews': 342,
      'imageUrl':
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            // Search Bar
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
                  const Spacer(),
                  const Icon(Icons.filter_list, color: Colors.black, size: 35),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                  children: List.generate(
                    categories.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                          if (index < destinations.length) {
                            buttonCarouselController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        });
                      },
                      child: _buildCategory(
                        categories[index],
                        selectedCategoryIndex == index,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Carousel
            CarouselSlider(
              items: destinations.map((destination) {
                return _buildDestinationCard(
                  title: destination['title'] as String,
                  subtitle: destination['subtitle'] as String,
                  rating: destination['rating'] as double,
                  reviews: destination['reviews'] as int,
                  imageUrl: destination['imageUrl'] as String,
                  isLiked: likedCards[destination['title']] ?? false,
                  onLikePressed: () {
                    setState(() {
                      likedCards[destination['title']] =
                          !(likedCards[destination['title']] ?? false);
                    });
                  },
                );
              }).toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                aspectRatio: 1.8,
                initialPage: 0,
                height: 405,
                onPageChanged: null, // we'll keep your logic below if needed
              ),
            ),
          ],
        ),
      ),

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
            _buildNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              isActive: true,
            ),
            _buildNavItem(
              icon: Icons.bookmark_border,
              activeIcon: Icons.bookmark,
              isActive: false,
            ),
            _buildNavItem(
              icon: Icons.heart_broken_rounded,
              activeIcon: Icons.explore,
              isActive: false,
            ),
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

  Widget _buildDestinationCard({
    required String title,
    required String subtitle,
    required double rating,
    required int reviews,
    required String imageUrl,
    required bool isLiked,
    required VoidCallback onLikePressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.8),
              Color.fromRGBO(0, 0, 0, 0.5),
              Colors.transparent,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Like button
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: onLikePressed,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ),

            // Bottom content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 22),
                        const SizedBox(width: 6),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "($reviews reviews)",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // SEE MORE BUTTON with navigation
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                destination: {
                                  'title': title,
                                  'subtitle': subtitle,
                                  'rating': rating,
                                  'reviews': reviews,
                                  'imageUrl': imageUrl,
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Text(
                            "See more",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        color: isActive ? Colors.black : Colors.grey.shade400,
        size: 24,
      ),
    );
  }

  Widget _buildCategory(String title, bool isSelected) {
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
