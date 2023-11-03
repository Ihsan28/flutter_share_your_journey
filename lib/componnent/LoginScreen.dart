import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_your_journey/componnent/HomeScreen.dart';

import 'FirebaseServices.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final User user;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _redirectToHomeIfLoggedIn() async {
    final User? currentUser = FirebaseServices.user;
    if (currentUser != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final UserCredential? authResult =
          await FirebaseServices().signInWithGoogle();

      if (authResult != null) {
        final User? user = authResult.user;

        if (user != null) {
          // Check if the widget is still in the widget tree
          _redirectToHomeIfLoggedIn();
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid gmail provided'),
              ),
            );
          }
        }
      }
    } catch (error) {
      print(error);
      // Handle errors here
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User? user = await FirebaseServices().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (user!.emailVerified) {
        // Check if the widget is still in the widget tree
        _redirectToHomeIfLoggedIn();
      } else {
        if (mounted) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'),
            ),
          );
        }
      }
    } catch (error) {
      print(error);
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your text logo here
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'SHARE YOUR JOURNEY',
                style: GoogleFonts.shadowsIntoLight(
                  // Lato is a good choice for a clean, modern look
                  textStyle: TextStyle(
                    fontSize: 34.0, // Adjust the size accordingly
                    fontWeight: FontWeight.bold, // Use bold font weight
                    color: Colors.green, // Choose a color that fits your theme
                    letterSpacing: 1.0, // Space out the letters just a bit
                    shadows: [
                      Shadow(
                        offset: const Offset(3.0, 3.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.25), // Soft shadow
                      ),
                    ],
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
                height: 32), // Add some space between logo and text fields
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                _signInWithEmailAndPassword();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.account_circle),
              label: const Text('Continue with Google'),
              onPressed: _signInWithGoogle,
            ),

            // Add a RichText for a more subtle 'sign up' prompt
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    const TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the sign-up screen when the text is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
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
}
