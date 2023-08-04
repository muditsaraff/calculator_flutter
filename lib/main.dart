import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Change the home to SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2), // Set the duration you want for the splash screen
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LogIn(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/whitebg.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/bmwlogo.png', // Replace with the path to your splash image
                  width: 200, // Set the desired width for the image
                  height: 200, // Set the desired height for the image
                ),
                SizedBox(height: 20), // Add some spacing between the splash image and the progress bar
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 209, 14, 14)), // Customize the color of the progress bar
                ),
              ],
            ),
        ),
        ],
      ),
    );
  }
}