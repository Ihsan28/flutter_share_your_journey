import 'package:flutter/material.dart';

import 'componnent/AddPlaceScreen.dart';
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
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const VerticalDivider(
                  width: 3,
                  thickness: 3,
                  color: Colors.brown,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...PlaceCardDetails.touristPlaces
                          .map((pcd) => PlaceCard(pcd)),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 3,
                  thickness: 3,
                  color: Colors.brown,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPlaceScreen(),
                ),
              );
            },
            tooltip: 'Add Place',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
