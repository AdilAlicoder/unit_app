import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time/Screens/AddUnit.dart';
import 'package:time/Screens/LoginScreen.dart';
import 'package:time/Screens/OnBoarding1.dart';
import 'package:time/Screens/SendRequest.dart';
import 'package:time/Screens/SignUpScreen.dart';
import 'package:time/Screens/TransferUnits.dart';
import 'package:time/Screens/codePicker.dart';


import 'Screens/BottomNavBar.dart';
import 'Screens/BottomNavigationBar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}


