import 'package:flutter/material.dart';

import '../model/Journey.dart';
import '../model/PlaceCardDetails.dart';

class JourneyBottomSheet {
  JourneyBottomSheet(
      {required this.context,
      required this.journeys,
      required this.onAddJourney(Journey journey),
      required this.onSelectJourney(Journey journey)}) {
    _showJourneyList();
  }

  final BuildContext context;
  final List<Journey> journeys;
  final Function? onAddJourney;
  final Function? onSelectJourney;

  void _showJourneyList() {
    TextEditingController _journeyNameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your Journeys',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _journeyNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter new journey name',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.blue),
                      onPressed: () {
                        if (_journeyNameController.text.isNotEmpty) {
                          final journey = Journey(
                              name: _journeyNameController.text,
                              places: PlaceCardDetails.touristPlaces);
                          onAddJourney!(journey);
                          //journeys.add(journey);
                          _journeyNameController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('New journey added!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: journeys.length,
                    itemBuilder: (context, index) {
                      final journey = journeys[index];
                      return ListTile(
                        leading: const Icon(Icons.directions_walk),
                        title: Text(journey.name ?? "Journey ${index + 1}"),
                        onTap: () {
                          Navigator.pop(context); // Close the bottom sheet
                          onSelectJourney!(journey);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
