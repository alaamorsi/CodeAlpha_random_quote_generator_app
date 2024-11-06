import 'package:flutter/material.dart';
import 'package:random_quote_generator/core/connectivity/dependency_injection.dart';
import 'package:random_quote_generator/core/constant/colors.dart';
import 'package:random_quote_generator/core/constant/functions.dart';
import 'package:random_quote_generator/features/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5), // Animation duration
      vsync: this,
    );

    // Define the fade animation from 0 (invisible) to 1 (fully visible)
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    // Define the scale animation, starting from 0.5x size and ending at normal size
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    // Add a listener to navigate when the animation completes
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToNextScreen(); // Call the method to navigate
      }
    });

    // Start the animation as soon as the screen is built
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Method to navigate to the next screen after the animation finishes
  void navigateToNextScreen() {
    DependencyInjection.init();
    navigateAndFinish(context, const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated for the main title text (scaling and fading in)
          FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: const Center(
                child: Text(
                  'My Quote',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Animated for the subtitle text (scaling and fading in)
          FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Center(
                child: Text(
                  'Random Quote Generator',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
