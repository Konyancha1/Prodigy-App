import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prodigy/navbar.dart';
import 'package:prodigy/calender_page.dart';
import 'package:prodigy/tasks_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SchedulePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalenderPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyTaskPage()),
        );
        break;
      case 3:
        FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEE, MMM/d/y').format(now);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/mockbg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Stack(
              children: const [
                Center(
                  child: Text(
                    "Prodigy",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: "Raleway",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<DataSnapshot>(
                stream:
                    Schedule.eventRef.onValue.map((event) => event.snapshot),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final schedules = <Schedule>[];
                    final data = snapshot.data as DataSnapshot;
                    final map = data.value as Map<dynamic, dynamic>? ?? {};
                    if (map.isEmpty) {
                      return const Center(
                          child: Text('No schedules available',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: "Raleway",
                              )));
                    }
                    map.forEach((key, value) {
                      final schedule = Schedule.fromJson(value);
                      schedule.id = key;
                      schedules.add(schedule);
                    });
                    return ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    schedule.scheduleName[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${schedule.scheduleName} from ${schedule.time}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "Raleway",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text(
                        'No schedules available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Raleway",
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
