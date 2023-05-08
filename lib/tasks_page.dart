import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prodigy/schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodigy/navbar.dart';
import 'package:prodigy/calender_page.dart';

class MyTaskPage extends StatefulWidget {
  const MyTaskPage({Key? key}) : super(key: key);

  @override
  _MyTaskPageState createState() => _MyTaskPageState();
}

class Task {
  String _taskName;
  String _reminder;
  bool _completed;
  String? _id;

  Task(this._taskName, this._reminder, [this._completed = false, this._id]);

  String get task => _taskName;
  String get reminder => _reminder;
  bool get completed => _completed;
  String get id => _id ?? '';

  set task(String value) {
    _taskName = value;
  }

  set reminder(String value) {
    _reminder = value;
  }

  set completed(bool value) {
    _completed = value;
  }

  set id(String value) => _id = value;

  Map<String, dynamic> toJson() => {
        'task': _taskName,
        'reminder': _reminder,
        'completed': _completed,
        'id': _id
      };

  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(json['task'], json['reminder'], json['completed'], json['id']);
}

class _MyTaskPageState extends State<MyTaskPage> {
  int _selectedIndex = 2;

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

  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _reminderController = TextEditingController();
  DatabaseReference _taskRef = FirebaseDatabase.instance.ref().child('tasks');

  Widget _buildForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SizedBox(
        height: 250,
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
                      child: TextFormField(
                        controller: _reminderController,
                        decoration: const InputDecoration(
                          labelText: 'Reminder Time',
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
                      String task = _taskNameController.text;
                      String reminder = _reminderController.text;

                      Task newTask = Task(task, reminder);
                      await _taskRef.push().set(newTask.toJson());

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Task created',
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
                stream: _taskRef.onValue.map((event) => event.snapshot),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final tasks = <Task>[];
                    final data = snapshot.data as DataSnapshot;
                    final map = data.value as Map<dynamic, dynamic>? ?? {};
                    map.forEach((key, value) {
                      final task = Task.fromJson(value);
                      task.id = key;
                      tasks.add(task);
                    });
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              Theme(
                                data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                    fillColor: MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    checkColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                child: Checkbox(
                                  value: task.completed,
                                  onChanged: (value) {
                                    setState(() {
                                      task.completed = value!;
                                    });
                                    _taskRef
                                        .child(task.id)
                                        .update(task.toJson());
                                  },
                                ),
                              ),
                              Text(
                                task._taskName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: "Raleway",
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
                      'No tasks available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Raleway",
                      ),
                    ));
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: 100,
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
                          size: 17.0,
                        ),
                        onPressed: () {
                          _showForm();
                        },
                      ),
                      const SizedBox(width: 1),
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
