import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time/Utils/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time/helper/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time/Screens/SignUpScreen.dart';
import 'package:time/admin_screen/admin_login.dart';
import 'BottomNavBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final  FirebaseAuth auth=FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 30),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      width: 110,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                "Assets/Images/logo.png",
                height: 90,
                width: 90,
              ),
              Image.asset(
                "Assets/Images/TIMEVAULT APP.png",
                width: 150,
                height: 80,
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid Email!';
                          } else if (value.length <= 2)
                            return 'More Than 2 words';
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 5),
                          border: InputBorder.none,
                          hintText: "Email Adress",
                          // prefixIcon: Icon(
                          //   Icons.email,
                          //   color: Colors.black,
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Password';
                          } else if (value.length < 8)
                            return 'Password should be at least 8 characters';
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 5),
                          border: InputBorder.none,
                          hintText: "Password",
                          // prefixIcon: Icon(
                          //   Icons.remove_red_eye,
                          //   color: Colors.black,
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password?",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        // decoration: TextDecoration.underline,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  loginuser();
                },
                child: Container(
                  height: 65,
                  width: 280,
                  child: Card(
                    color: Color(0xff5E17EB),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              // decoration: TextDecoration.underline,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("__________________"),
                  Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("__________________"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  //  _loginUser(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                child: Container(
                  height: 65,
                  width: 280,
                  child: Card(
                    color: Color(0xff5E17EB),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        "BECOME A PARTNER",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("Assets/Images/gmail.png",
                        height: 60, width: 60),
                    Image.asset("Assets/Images/facebook.png",
                        height: 60, width: 60),
                    Image.asset("Assets/Images/instagram.png",
                        height: 60, width: 60)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: InkWell(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Adminloging()),
                  );
                },
                  child: Text('I`m Admin',style: TextStyle(fontSize: 22.0,color: Colors.blueAccent,fontWeight: FontWeight.bold),))),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginuser() async {
    User user;
    // if(_emailController=='afdmin'&&pass'adi'){
    //
    // }
    user = (await auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;
    if (user == null) {
      _showDialog(context);
    }
    else {
      Fluttertoast.showToast(
          msg: "Please wait",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Bottomnavigation('rfrrf','rfr4fcrfc')));
    }
  }
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return Center(
            child: AlertDialog(
              backgroundColor: Color(0xff8AF3D8),
              title: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text('Error message'),
                        SizedBox(
                          height: 21,
                        ),
                        Text('Please check email and password is correct'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void createChatRoom(username) {
    List<String> users = [Constants.myName,'admin'];
    String chatRoomId = getChatRoomId(Constants.myName,'admin');
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };
    databaseMethods.addChatRoom(chatRoom, chatRoomId);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Bottomnavigation(chatRoomId,username)));
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

