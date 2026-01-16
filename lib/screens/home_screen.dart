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
        toolbarHeight: 80, // Added height for better spacing
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Vanessa",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28, // Bigger title
                fontWeight: FontWeight.w900, // Extra bold
                letterSpacing: -0.5,
              ),
            ),
            Text(
              "Welcome to Trip Glide",
              style: TextStyle(
                color: Colors.grey.shade500, // Modern soft grey
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
              backgroundImage: AssetImage("images/profile_pic.jpg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar - Fixed to double.infinity
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
                height: 420,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                aspectRatio: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
              ),
            ),
          ],
        ),
      ),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 28,
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

                  // THE FIXED "SEE MORE" BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            destination: {
                              'name':
                                  title, // Changed key to 'name' to match your DetailScreen
                              'imageUrl': imageUrl,
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double
                          .infinity, // Now spans the full width of the card
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
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
                          Spacer(), // Pushes arrow to far right
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
