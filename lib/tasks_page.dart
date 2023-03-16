import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prodigy/calender_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodigy/navbar.dart';
import 'package:prodigy/schedule.dart';

class MyTaskPage extends StatefulWidget {
  const MyTaskPage({Key? key}) : super(key: key);

  @override
  _MyTaskPageState createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<MyTaskPage> {
  int _selectedIndex = 2;
  List<String> _tasks = [];
  List<bool> _isCheckedList = [];

  void addTask(String taskName) {
    setState(() {
      _tasks.add(taskName);
      _isCheckedList.add(false);
    });
  }

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

  TextEditingController _taskNameController = TextEditingController();

  Widget _buildForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SizedBox(
        height: 380,
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
                        controller: _taskNameController,
                        decoration: const InputDecoration(
                          labelText: 'Task Name',
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
                          labelText: 'Reminder',
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
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String taskName = _taskNameController.text;
                      addTask(taskName);
                      Navigator.of(context).pop();
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
              children: [
                const Center(
                  child: Text(
                    "Prodigy",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    onPressed: () {
                      // Show settings page
                    },
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      _tasks[index],
                      style: TextStyle(
                        color:
                            _isCheckedList[index] ? Colors.grey : Colors.white,
                        decoration: _isCheckedList[index]
                            ? TextDecoration.lineThrough
                            : null,
                        fontFamily: "Raleway",
                      ),
                    ),
                    value: _isCheckedList[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _isCheckedList[index] = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    tileColor: Colors.white,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20.0,
                        ),
                        onPressed: () {
                          _showForm();
                        },
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "ToDo",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
