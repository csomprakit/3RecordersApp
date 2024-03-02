import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final BeamerDelegate beamerDelegate;
  final int currentIndex;

  const BottomNavigation({Key? key, required this.beamerDelegate,
    required this.currentIndex,}) : super(key: key);

  @override
  _BottomNavigationState createState() =>
      _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      items: [
        BottomNavigationBarItem(
          label: 'Diet',
          icon: Icon(Icons.restaurant),
        ),
        BottomNavigationBarItem(
          label: 'Emotion',
          icon: Icon(Icons.emoji_emotions),
        ),
        BottomNavigationBarItem(
          label: 'Workout',
          icon: Icon(Icons.sports_gymnastics),
        ),
        BottomNavigationBarItem(
          label: 'User',
          icon: Icon(Icons.person),
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          widget.beamerDelegate.beamToNamed('/diet');
        } else if (index == 1) {
          widget.beamerDelegate.beamToNamed('/emotion');
        } else if (index == 2) {
          widget.beamerDelegate.beamToNamed('/workout');
        }
        else if (index == 3) {
          widget.beamerDelegate.beamToNamed('/user');
        }
      },
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
    );
  }
}
