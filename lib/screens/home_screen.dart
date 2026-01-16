import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart'; // Ensure this file exists with a DetailScreen widget

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
  );
}

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
    "South America",
    "Asia",
    "Europe",
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
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Vanessa",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              "Welcome to Trip Glide",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage("images/profile_pic.jpg"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Added to prevent overflow on smaller screens
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 28, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      "Search",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    Spacer(),
                    Icon(Icons.filter_list, color: Colors.black, size: 28),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Select your next trip",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 15),

              // Horizontal Category List
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                          // Jump to page if it exists in the carousel
                          if (index < destinations.length) {
                            buttonCarouselController.animateToPage(index);
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

              const SizedBox(height: 25),

              // Carousel Slider
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
                  height: 450,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  aspectRatio: 1.0,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      // Syncs the category highlights with the auto-playing slides
                      selectedCategoryIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      // Set extendBody to true to let the list scroll behind the floating nav
      extendBody: true,
      bottomNavigationBar: _buildBottomNav(),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
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
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),

            // Bottom content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "$rating ($reviews reviews)",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // SEE MORE BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            destination: {
                              'name': title,
                              'imageUrl': imageUrl,
                              'location': subtitle,
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "See more",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_circle_right_rounded,
                            size: 45,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.bookmark_border, color: Colors.grey),
          Icon(Icons.favorite_outline, color: Colors.grey),
          Icon(Icons.person_outline, color: Colors.grey),
        ],
      ),
    );
  }
}
