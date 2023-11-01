import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';

import 'AddPlaceScreen.dart';

class FloatingActionBubbleButton extends StatefulWidget {
  const FloatingActionBubbleButton({super.key});

  @override
  State<FloatingActionBubbleButton> createState() =>
      _FloatingActionBubbleButtonState();
}

class _FloatingActionBubbleButtonState extends State<FloatingActionBubbleButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      child: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Settings",
            iconColor: Colors.white,
            bubbleColor: Colors.blueGrey,
            icon: Icons.settings,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title: "Journeys",
            iconColor: Colors.white,
            bubbleColor: Colors.blueGrey,
            icon: Icons.view_list,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title: "add place",
            iconColor: Colors.white,
            bubbleColor: Colors.blueGrey,
            icon: Icons.mode_of_travel_outlined,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddPlaceScreen()));
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

        iconColor: Colors.blueGrey,
        iconData: Icons.ac_unit,
        backGroundColor: const Color.fromRGBO(183, 245, 236, 0.5),
      ),
    );
  }
}
