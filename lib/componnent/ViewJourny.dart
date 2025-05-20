import 'package:flutter/material.dart';
import 'package:path_share/componnent/JourneyBottomSheet.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../model/Journey.dart';
import '../model/PlaceCardDetails.dart';
import 'CardWithPlaceInfo.dart';
import 'FloatingActionBubbleButton.dart';
import 'TimeLineIndicator.dart';

class ViewJourney extends StatefulWidget {
  const ViewJourney({super.key});

  @override
  State<ViewJourney> createState() => _ViewJourneyState();
}

class _ViewJourneyState extends State<ViewJourney> {
  List<Journey> journeys = [
    Journey(name: "Journey 1", places: [/*...list of places...*/]),
    Journey(name: "Journey 2", places: [/*...list of places...*/]),
    // Add more journeys...
  ];

  void onAddJourney(Journey journey) {
    setState(() {
      journeys.add(journey);
    });
  }

  void onSelectJourney(Journey journey) {
    setState(() {
      // Update the places to display based on the selected journey
      PlaceCardDetails.touristPlaces = journey.places!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Journey'),
        actions: [
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                JourneyBottomSheet(
                  context: context,
                  journeys: journeys,
                  onAddJourney: onAddJourney,
                  onSelectJourney: onSelectJourney,
                );
              }),
        ],
      ),

      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: PlaceCardDetails.touristPlaces.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final place = PlaceCardDetails.touristPlaces[index];
            final isEven = index % 2 == 0;
            final isLast = index == PlaceCardDetails.touristPlaces.length - 1;
            final isFirst = index == 0;

            var shortLocation = place.location!.split(',')[0];

            double getShortLocationHeight() {
              var height = 80.0;
              if (shortLocation.length > 48) {
                height = 140.0;
              } else if (shortLocation.length > 32) {
                height = 120.0;
              } else if (shortLocation.length > 16) {
                height = 100.0;
              }
              return height;
            }

            return Column(
              children: [
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: isEven ? 0.15 : 0.85,
                  isFirst: isFirst,
                  isLast: isLast,
                  indicatorStyle: IndicatorStyle(
                    width: 80,
                    height: getShortLocationHeight(),
                    indicator: TimeLineIndicator(
                      location: shortLocation,
                      time: place.time ?? DateTime.now(),
                    ),
                    indicatorXY: 0.5,
                    color: Colors.cyan,
                    drawGap: true,
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.blueGrey,
                    thickness: 5,
                  ),
                  startChild: !isEven
                      ? GestureDetector(
                          child: CardWithPlaceInfo(pcd: place),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CardWithPlaceInfo(pcd: place),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  endChild: isEven
                      ? GestureDetector(
                          child: CardWithPlaceInfo(pcd: place),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CardWithPlaceInfo(pcd: place),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  afterLineStyle: const LineStyle(
                    color: Colors.blueGrey,
                    thickness: 5,
                  ),
                ),
                if (!isLast)
                  TimelineDivider(
                    begin: 0.1,
                    end: 0.9,
                    thickness: 3,
                    color: isEven ? Colors.purple : Colors.deepOrange,
                  )
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      //Init Floating Action Bubble
      floatingActionButton: const FloatingActionBubbleButton(),
    );
  }
}
