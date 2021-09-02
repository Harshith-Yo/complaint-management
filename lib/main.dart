import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_management/constants.dart';
import 'package:complaint_management/screens/admin_home.dart';
import 'package:complaint_management/screens/techni_home.dart';
import 'package:complaint_management/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var role;
  @override
  void initState() {
    checkRole();
    super.initState();
  }

  checkRole() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      try {
        setState(() {
          role = value['role'];
        });
      } catch (e) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .set({'role': 'student'});
        setState(() {
          role = 'student';
        });
      }
    });
    if (FirebaseAuth.instance.currentUser == null)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    else if (role == 'admin')
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminHome()));
    else if (role == 'technician')
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TechniHome()));
    else
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}
