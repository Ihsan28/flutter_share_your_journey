import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocationWithDateTime extends StatefulWidget {
  const LocationWithDateTime(
      {super.key, required this.location, required this.time});
  final String? location;
  final DateTime? time;

  @override
  State<LocationWithDateTime> createState() => _LocationWithDateTimeState();
}

class _LocationWithDateTimeState extends State<LocationWithDateTime> {
  String formatDateTime(DateTime? dateTime) {
    return DateFormat('hh:mm a').format(dateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location Card
        /*Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 16),
            Row(
              children: [
                Wrap(
                  children: [
                    Card(
                      color: Colors.blueGrey[50],
                      shadowColor: Colors.blueGrey[200],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.location ?? 'Location',
                            style: const TextStyle(fontSize: 12, shadows: [
                              Shadow(
                                color: Color.fromARGB(111, 111, 111, 111),
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),*/

        // Time Card
        Row(
          children: [
            Wrap(
              children: [
                Card(
                  color: Colors.blueGrey[50],
                  shadowColor: Colors.blueGrey[200],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        formatDateTime(widget.time),
                        style: const TextStyle(fontSize: 10, shadows: [
                          Shadow(
                            color: Color.fromARGB(111, 111, 111, 111),
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.access_time,
                  size: 15,
                  color: Colors.white,
                )),
          ],
        ),
      ],
    );
  }
}
