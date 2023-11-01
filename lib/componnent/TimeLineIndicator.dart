import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLineIndicator extends StatefulWidget {
  const TimeLineIndicator(
      {super.key, required this.location, required this.time});
  final String location;
  final DateTime time;

  @override
  State<TimeLineIndicator> createState() => _TimeLineIndicatorState();
}

class _TimeLineIndicatorState extends State<TimeLineIndicator> {
  String getDate(DateTime? dateTime) {
    return DateFormat('dd MMM yy').format(dateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.blueGrey,
        ),
        Text.rich(
          TextSpan(
            text: widget.location[0], // Get the first character
            style: const TextStyle(
              fontSize: 18, // Bigger font size for the first character
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),

            children: [
              TextSpan(
                text: widget.location
                    .split(',')[0]
                    .substring(1), // Get the rest of the string
                style: const TextStyle(
                  fontSize: 12, // Smaller font size for the rest
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontStyle:
                      FontStyle.italic, // Added italic for a touch of style
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          getDate(widget.time),
          style: const TextStyle(
            fontSize: 10, // Reduced font size for a more concise look
            fontWeight: FontWeight.w800, // Semi-bold weight
            color: Colors.blueGrey, // Slightly brighter shade of blue
            letterSpacing: 0.2, // Added spacing between letters for style
          ),
        ),
      ],
    );
  }
}
