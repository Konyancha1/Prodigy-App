import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prodigy/calender_page.dart';
import 'package:prodigy/navbar.dart';
import 'package:prodigy/tasks_page.dart';

class MyScheduleForm extends StatefulWidget {
  @override
  _MyScheduleFormState createState() => _MyScheduleFormState();
}

class _MyScheduleFormState extends State<MyScheduleForm> {
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

  List<DropdownMenuItem<String>> _hourList() {
    return <DropdownMenuItem<String>>[
      const DropdownMenuItem(
        value: '12:00 AM',
        child: Text('12:00 AM'),
      ),
      const DropdownMenuItem(
        value: '1:00 AM',
        child: Text('1:00 AM'),
      ),
      const DropdownMenuItem(
        value: '2:00 AM',
        child: Text('2:00 AM'),
      ),
      const DropdownMenuItem(
        value: '3:00 AM',
        child: Text('3:00 AM'),
      ),
      const DropdownMenuItem(
        value: '4:00 AM',
        child: Text('4:00 AM'),
      ),
      const DropdownMenuItem(
        value: '5:00 AM',
        child: Text('5:00 AM'),
      ),
      const DropdownMenuItem(
        value: '6:00 AM',
        child: Text('6:00 AM'),
      ),
      const DropdownMenuItem(
        value: '7:00 AM',
        child: Text('7:00 AM'),
      ),
      const DropdownMenuItem(
        value: '8:00 AM',
        child: Text('8:00 AM'),
      ),
      const DropdownMenuItem(
        value: '9:00 AM',
        child: Text('9:00 AM'),
      ),
      const DropdownMenuItem(
        value: '10:00 AM',
        child: Text('10:00 AM'),
      ),
      const DropdownMenuItem(
        value: '11:00 AM',
        child: Text('11:00 AM'),
      ),
      const DropdownMenuItem(
        value: '12:00 PM',
        child: Text('12:00 PM'),
      ),
      const DropdownMenuItem(
        value: '1:00 PM',
        child: Text('1:00 PM'),
      ),
      const DropdownMenuItem(
        value: '2:00 PM',
        child: Text('2:00 PM'),
      ),
      const DropdownMenuItem(
        value: '3:00 PM',
        child: Text('3:00 PM'),
      ),
      const DropdownMenuItem(
        value: '4:00 PM',
        child: Text('4:00 PM'),
      ),
      const DropdownMenuItem(
        value: '5:00 PM',
        child: Text('5:00 PM'),
      ),
      const DropdownMenuItem(
        value: '6:00 PM',
        child: Text('6:00 PM'),
      ),
      const DropdownMenuItem(
        value: '7:00 PM',
        child: Text('7:00 PM'),
      ),
      const DropdownMenuItem(
        value: '8:00 PM',
        child: Text('8:00 PM'),
      ),
      const DropdownMenuItem(
        value: '9:00 PM',
        child: Text('9:00 PM'),
      ),
      const DropdownMenuItem(
        value: '10:00 PM',
        child: Text('10:00 PM'),
      ),
      const DropdownMenuItem(
        value: '11:00 PM',
        child: Text('11:00 PM'),
      ),
    ];
  }

  List<DropdownMenuItem<Duration>> _durationList() {
    return <DropdownMenuItem<Duration>>[
      const DropdownMenuItem(
        value: Duration(minutes: 15),
        child: Text('15 minutes'),
      ),
      const DropdownMenuItem(
        value: Duration(minutes: 30),
        child: Text('30 minutes'),
      ),
      const DropdownMenuItem(
        value: Duration(hours: 1),
        child: Text('1 hour'),
      ),
      const DropdownMenuItem(
        value: Duration(hours: 2),
        child: Text('2 hours'),
      ),
      const DropdownMenuItem(
        value: Duration(hours: 3),
        child: Text('3 hours'),
      ),
      const DropdownMenuItem(
        value: Duration(hours: 4),
        child: Text('4 hours'),
      ),
      const DropdownMenuItem(
        value: Duration(hours: 5),
        child: Text('5 hours'),
      ),
    ];
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
          MaterialPageRoute(builder: (context) => const CalenderPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyScheduleForm()),
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

  Widget _buildForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SizedBox(
        height: 530,
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
                      child: DropdownButtonFormField<String>(
                        items: _hourList(),
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (String? value) {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButtonFormField<Duration>(
                        items: _durationList(),
                        decoration: const InputDecoration(
                          labelText: 'Duration',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (Duration? value) {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButtonFormField<String>(
                        value: 'Tone 1',
                        items: const [
                          DropdownMenuItem(
                            value: 'Tone 1',
                            child: Text('Tone 1'),
                          ),
                          DropdownMenuItem(
                            value: 'Tone 2',
                            child: Text('Tone 2'),
                          ),
                          DropdownMenuItem(
                            value: 'Tone 3',
                            child: Text('Tone 3'),
                          ),
                        ],
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          labelText: 'Alarm Tone',
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
                      child: DropdownButtonFormField<String>(
                        value: 'Grey',
                        items: const [
                          DropdownMenuItem(
                            value: 'Red',
                            child: Text('Red'),
                          ),
                          DropdownMenuItem(
                            value: 'Yellow',
                            child: Text('Yellow'),
                          ),
                          DropdownMenuItem(
                            value: 'Green',
                            child: Text('Green'),
                          ),
                          DropdownMenuItem(
                            value: 'Grey',
                            child: Text('Grey'),
                          ),
                        ],
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          labelText: 'Color',
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
                    onPressed: () {
                      // What to happen after done is clicked
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
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
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () {
              _showForm();
            },
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
