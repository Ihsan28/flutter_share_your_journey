import 'package:firebase_core/firebase_core.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_your_journey/componnent/AddPlaceScreen.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'componnent/PlaceCard.dart';
import 'firebase_options.dart';
import 'model/PlaceCardDetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = PlaceCardDetails.touristPlaces;
    return MaterialApp(
      title: 'Share Your Journey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: Scaffold(
          // body: ListView.builder(
          //   itemCount: list.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     final place = PlaceCardDetails.touristPlaces[index];
          //     final example = place;
          //
          //     return TimelineTile(
          //       alignment: TimelineAlign.manual,
          //       lineXY: index.isEven ? 0.1 : 0.9,
          //       isFirst: index == 0,
          //       isLast: index == list.length - 1,
          //       indicatorStyle: IndicatorStyle(
          //         width: 30,
          //         color: Colors.blue,
          //         indicatorXY: 0.7,
          //         iconStyle: IconStyle(
          //           color: Colors.white,
          //           iconData: Icons.thumb_up,
          //         ),
          //       ),
          //       beforeLineStyle: LineStyle(
          //         color: Colors.black.withOpacity(0.6),
          //       ),
          //       endChild: GestureDetector(
          //         child: PlaceCard(pcd: example),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (_) => PlaceCard(pcd: example),
          //             ),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),
          body: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: PlaceCardDetails.touristPlaces.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final place = PlaceCardDetails.touristPlaces[index];
                final isEven = index % 2 == 0;
                final isLast =
                    index == PlaceCardDetails.touristPlaces.length - 1;
                final isFirst = index == 0;

                return Column(
                  children: [
                    TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: isEven ? 0.3 : 0.7,
                      isFirst: isFirst,
                      isLast: isLast,
                      indicatorStyle: IndicatorStyle(
                        padding: const EdgeInsets.all(8),
                        width: 100,
                        indicator: Column(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              '${place.location?.split(',')[0]}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        iconStyle: IconStyle(
                          color: Colors.white,
                          iconData: Icons.location_on_outlined,
                        ),
                        color: Colors.cyan,
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.deepOrange,
                        thickness: 6,
                      ),
                      startChild: !isEven
                          ? GestureDetector(
                              child: PlaceCard(pcd: place),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PlaceCard(pcd: place),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                      endChild: isEven
                          ? GestureDetector(
                              child: PlaceCard(pcd: place),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PlaceCard(pcd: place),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                      afterLineStyle: const LineStyle(
                        color: Colors.deepOrange,
                        thickness: 6,
                      ),
                    ),
                    if (!isLast)
                      TimelineDivider(
                        begin: isEven ? 0.1 : 0.1,
                        end: isEven ? 0.9 : 0.9,
                        thickness: 6,
                        color: isEven ? Colors.purple : Colors.deepOrange,
                      )
                  ],
                );
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

          //Init Floating Action Bubble
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionBubble(
              // Menu items
              items: <Bubble>[
                // Floating action menu item
                Bubble(
                  title: "Settings",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.settings,
                  titleStyle:
                      const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    _animationController.reverse();
                  },
                ),
                // Floating action menu item
                Bubble(
                  title: "Profile",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.people,
                  titleStyle:
                      const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    _animationController.reverse();
                  },
                ),
                //Floating action menu item
                Bubble(
                  title: "Home",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.home,
                  titleStyle:
                      const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddPlaceScreen()));
                    _animationController.reverse();
                  },
                ),
              ],

              // animation controller
              animation: _animation,

              // On pressed change animation state
              onPress: () => _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward(),

              // Floating Action button Icon color
              iconColor: Colors.blue,

              // Flaoting Action button Icon
              iconData: Icons.ac_unit,
              backGroundColor: const Color.fromRGBO(183, 245, 236, 1.0),
            ),
          )),
    );
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 4,
          ),
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample({Key? key, required this.example}) : super(key: key);

  final PlaceCardDetails example;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              example.title!,
              style: GoogleFonts.jura(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          const Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 26,
          ),
        ],
      ),
    );
  }
}
