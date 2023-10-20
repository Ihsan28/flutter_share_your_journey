import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: PlaceCard(PlaceCardDetails(
            title: 'City Of mosque, Dhaka',
            description: 'Dhanmondi, Dhaka............',
          )),
        ),
      ),
    );
  }
}

class PlaceCard extends StatefulWidget {
  const PlaceCard(this.pcd, {super.key});

  final PlaceCardDetails pcd;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  PlaceCardDetails get pcd => widget.pcd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Card(
          child: Row(
            children: [
              Text(
                pcd.location ?? 'Location',
                style: const TextStyle(fontSize: 20, shadows: [
                  Shadow(
                    color: Color.fromARGB(111, 111, 111, 111),
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ]),
              ),
              const Spacer(),
              Text(
                pcd.time?.toString() ?? 'Time',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 300,
          child: Card(
            child: Column(
              children: [
                pcd.images != null
                    ? Image.network(pcd.images![0])
                    : const SizedBox.shrink(),
                const SizedBox(height: 16),
                Text(
                  pcd.title ?? 'Place Name',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  pcd.description ?? 'Place Description',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
