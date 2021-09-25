import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreen1.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen(
      {Key key,
      menuScreenContext,
      bool hideStatus,
      Null Function() onScreenHideButtonPressed})
      : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String uid;
  String name;
  String username;
  String units;
  String number;
  String email;
  final FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    // TODO: implement initState
    super.initState();
    currentuser();
  }

  Future<void> currentuser() async {
    final User user = await auth.currentUser;
    Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot snap) {
      setState(() {
        uid = user.uid;
        name = snap['Name'];
        username = snap['username'];
        email = snap['email'];
        units = snap['units'].toString();
      });
    });
  }

  File _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("Assets/Images/1.png")),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => HomeScreen1()));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Text(
                        "Account",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                          color: Color(0xff5E17EB),
                          // decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 30),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: _file == null
                                  ? AssetImage("Assets/Images/drawerProfle.png")
                                  : FileImage(_file),
                              fit: BoxFit.cover)),
                    ),
                    Positioned.fill(
                      top: -50,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 19,
                            ),
                            onPressed: getFile,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff5E17EB),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Text("Tap to Change",
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      // decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                  child: Text('Name : $name',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.bold),)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                color:Colors.blue,
              ),
              SizedBox(
                height: 35,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Username : $username',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.bold),)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                color:Colors.blue,
              ),
              SizedBox(
                height: 35,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Email : $email',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.bold),)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                color:Colors.blue,
              ),
              SizedBox(
                height: 35,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Units : $units',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.bold),)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                color:Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getFile() async {
    _file = await FilePicker.getFile();
    setState(() {
      if (_file != null) {
        _file = File(_file.path);
      } else {
        print('No image selected.');
      }
    });
  }
}

class HomeScreen {}
