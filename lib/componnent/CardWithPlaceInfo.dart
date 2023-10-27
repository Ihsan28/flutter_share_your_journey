import 'package:flutter/material.dart';
import 'package:share_your_journey/model/PlaceCardDetails.dart';

class CardWithPlaceInfo extends StatefulWidget {
  const CardWithPlaceInfo({super.key, required this.pcd});
  final PlaceCardDetails pcd;

  @override
  State<CardWithPlaceInfo> createState() => _CardWithPlaceInfoState(pcd);
}

class _CardWithPlaceInfoState extends State<CardWithPlaceInfo> {
  _CardWithPlaceInfoState(this.pcd);
  final PlaceCardDetails pcd;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan[50],
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
    );
  }
}
