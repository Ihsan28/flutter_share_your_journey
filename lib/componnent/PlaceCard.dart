import 'package:flutter/material.dart';

import '../model/PlaceCardDetails.dart';

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
                style: const TextStyle(fontSize: 12, shadows: [
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
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 500,
          child: Card(
            child: Column(
              children: [
                pcd.images != null
                    ? SizedBox(
                        height: 70,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...pcd.images!.map(
                                (image) => Container(
                                  padding: const EdgeInsets.all(1.0),
                                  height: 70,
                                  width: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
