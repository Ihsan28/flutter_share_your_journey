import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_journey/componnent/HomeScreen.dart';

import 'FirebaseServices.dart';

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
    _redirectToHomeIfLoggedIn();
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
      final bool isSignedIn =
          await FirebaseServices().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (isSignedIn) {
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
