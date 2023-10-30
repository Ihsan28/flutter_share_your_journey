import 'package:flutter/material.dart';
import 'package:share_your_journey/componnent/CardWithPlaceInfo.dart';
import 'package:share_your_journey/componnent/LocationWithDateTime.dart';

import '../model/PlaceCardDetails.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({super.key, required this.pcd});

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
        LocationWithDateTime(location: pcd.location, time: pcd.time),
        const SizedBox(height: 1),
        CardWithPlaceInfo(pcd: pcd),
      ],
    );
  }
}
