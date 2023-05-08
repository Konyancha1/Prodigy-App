import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodigy/calender_page.dart';
import 'package:prodigy/schedule.dart';
import 'package:prodigy/utils.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isVerified = false;
  bool resendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => resendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        resendEmail = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString(), ScaffoldMessenger.of(context));
    }
  }

  @override
  Widget build(BuildContext context) => isVerified
      ? CalenderPage()
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 80),
                Text(
                  'A verification email has been sent!',
                  style: TextStyle(fontFamily: 'Raleway', fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    'Resend Email',
                    style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                  ),
                  onPressed: () {
                    resendEmail ? sendVerificationEmail() : null;
                  },
                ),
                SizedBox(height: 25),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        );
}
