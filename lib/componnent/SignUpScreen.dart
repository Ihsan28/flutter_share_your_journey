import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'HomeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

enum Gender { male, female, other }

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Gender? _selectedGender;
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadFile(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('uploads/${DateTime.now().toString()}');
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        String imageUrl = '';
        if (_image != null) {
          imageUrl = await uploadFile(_image!);
        }

        final String password = _passwordController.text;

        // Create the user with FirebaseAuth
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: password,
        );

        // If the FirebaseAuth signup is successful, upload the user details to Firestore
        if (userCredential.user != null) {
          // Get the user's UID from FirebaseAuth
          String uid = userCredential.user!.uid;
          String genderString = _selectedGender != null
              ? _selectedGender.toString().split('.').last
              : '';

          // Create a reference to the user's document in Firestore
          DocumentReference userDocRef =
              FirebaseFirestore.instance.collection('users').doc(uid);

          // Set the user's data
          await userDocRef.set({
            'name': _nameController.text,
            'age': _ageController.text,
            'gender': genderString,
            'email': _emailController.text,
            'image': imageUrl,
            // Initialize journeys as an empty array or map, depending on your preferred structure
            'journeys': [],
          });

          // Optionally, create a placeholder for the first journey with places
          // This step is optional and can be omitted if you want to start with a completely empty 'journeys' collection
          await userDocRef.collection('journeys').add({
            'title': '', // Placeholder title
            'description': '', // Placeholder description
            'places': [], // Empty array for places
            // Add more fields as necessary
          });

          // Navigate to the next screen or show a success message
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen()), // Replace with your home screen
          );

          // Optionally show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign Up Successful')),
          );
        }
      } on FirebaseAuthException catch (authError) {
        // Handle FirebaseAuth errors here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: ${authError.message}')),
        );
      } catch (e) {
        // Handle other errors here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            // Clickable rounded avatar
            Center(
              child: GestureDetector(
                onTap: getImage,
                // Call the getImage method when the avatar is tapped
                child: CircleAvatar(
                  radius: 60, // Size of the avatar
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 60,
                          color: Colors.grey.shade800,
                        )
                      : null, // Show camera icon if no image is selected
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: List<Widget>.generate(
                Gender.values.length,
                (int index) {
                  return ChoiceChip(
                    label:
                        Text(Gender.values[index].toString().split('.').last),
                    selected: _selectedGender == Gender.values[index],
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedGender =
                            selected ? Gender.values[index] : null;
                      });
                    },
                    // Styling for selected and unselected states
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: _selectedGender == Gender.values[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                    backgroundColor: Colors.grey.shade300,
                  );
                },
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true, // This ensures the text is hidden
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length < 4 || value.length > 20) {
                  return 'Password must be between 4 and 20 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _selectedGender = null;
    _passwordController.dispose();
    super.dispose();
  }
}
