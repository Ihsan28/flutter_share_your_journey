import 'package:flutter/material.dart';
import 'package:path_share/model/PlaceCardDetails.dart';

import 'LocationWithDateTime.dart';

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
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.cyan[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          child: Column(
            children: [
              LocationWithDateTime(location: pcd.location, time: pcd.time),
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
              Text(
                pcd.title ?? 'Place Name',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                pcd.description ?? 'Place Description',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
