import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prodigy/schedule.dart';
import 'package:prodigy/navbar.dart';
import 'package:prodigy/tasks_page.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

DatabaseReference _eventRef = FirebaseDatabase.instance.ref().child('events');

class Schedule {
  String _scheduleName;
  String _time;
  String _duration;
  String? _id;

  Schedule(this._scheduleName, this._time, this._duration, [this._id]);

  String get scheduleName => _scheduleName;
  String get time => _time;
  String get duration => _duration;
  String get id => _id ?? '';

  set scheduleName(String value) {
    _scheduleName = value;
  }

  set time(String value) {
    _time = value;
  }

  set duration(String value) {
    _duration = value;
  }

  set id(String value) => _id = value;

  Map<String, dynamic> toJson() => {
        'scheduleName': _scheduleName,
        'time': _time,
        'duration': _duration,
        'id': _id
      };

  static DatabaseReference get eventRef => _eventRef;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
      json['scheduleName'], json['time'], json['duration'], json['id']);
}

class _CalenderPageState extends State<CalenderPage> {
  void _showForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildForm(context),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isDismissible: true,
    );
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchedulePage()),
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
          MaterialPageRoute(builder: (context) => MyTaskPage()),
        );
        break;
      case 3:
        FirebaseAuth.instance.signOut();
    }
  }

  TextEditingController eventController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  Widget _buildForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SizedBox(
        height: 320,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Container(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: eventController,
                        decoration: const InputDecoration(
                          labelText: 'Event Details',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: timeController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Time',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: durationController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Duration in Hours',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      String time = timeController.text;
                      String duration = durationController.text;
                      String schedule = eventController.text;

                      Schedule newEvent = Schedule(schedule, time, duration);

                      await _eventRef.push().set(newEvent.toJson());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Schedule added',
                              style: TextStyle(color: Colors.black)),
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime today = DateTime.now();

  void _onSelected(DateTime day, DateTime focusedDay) {
    _showForm();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              TableCalendar(
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                      color: Colors.white, fontFamily: "Raleway", fontSize: 20),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                onDaySelected: _onSelected,
                calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Raleway",
                )),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
