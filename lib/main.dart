import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/provider/travel_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TravelProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip App',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const HomeScreen(),
    );
  }
}
