import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onItemTapped;

  const MyBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: Text(
            'My Schedule',
            style: TextStyle(color: Colors.black),
          ).data!,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: Text(
            'Calender',
            style: TextStyle(color: Colors.black),
          ).data!,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: Text(
            'Tasks',
            style: TextStyle(color: Colors.black),
          ).data!,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app),
          label: Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ).data!,
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.black,
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      showUnselectedLabels: true,
      onTap: widget.onItemTapped,
    );
  }
}
