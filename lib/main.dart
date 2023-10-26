import 'package:flutter/material.dart';

import 'componnent/PlaceCard.dart';
import 'model/PlaceCardDetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Your Journey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: PlaceCard(PlaceCardDetails(
            title: 'City Of mosque, Dhaka',
            description: 'Dhanmondi, Dhaka............',
            location: 'Dhaka, Bangladesh',
            time: DateTime.now(),
            images: [
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPfO37MK81JIyR1ptwqr_vYO3w4VR-iC2wqQ&usqp=CAU',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgf48x3wcFMN1udiL_f7m_BYz57ZNokbJ5zA&usqp=CAU',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsJSFvewBphCd0-gaP5jDukdNiNsEaaiOnYA&usqp=CAU',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZyDj_fcin3DUZIMq1yV0tr9USTNcZKdmeIg&usqp=CAU',
            ],
          )),
        ),
      ),
    );
  }
}
