import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    // Wait for Firebase to initialize and user authentication state to be retrieved
    await Future.delayed(
        const Duration(milliseconds: 1500)); // 1.5 seconds delay

    // Check the authentication status
    FirebaseAuth.instance.authStateChanges().first.then((user) {
      if (user != null) {
        // If the user is logged in, navigate to HomeScreen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // If the user is not logged in, navigate to LoginScreen
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Replace with your application's logo or image file
            Image.asset(
              'assets/splash.png',
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
