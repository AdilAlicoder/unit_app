import 'package:flutter/material.dart';
import 'package:time/admin_screen/admin_home.dart';
class Adminloging extends StatefulWidget {
  @override
  _AdminlogingState createState() => _AdminlogingState();
}

class _AdminlogingState extends State<Adminloging> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
    void check(){
      if(_emailController.text == 'admin123@gmail.com' && _passwordController.text == 'adminadmin'){
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => admin_home()),
        );
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 30),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {},
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
              // key: _formKey,
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
              height: 35,
            ),
            GestureDetector(
              onTap: check,
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
                      style: TextStyle(
                          color: Colors.white,
                          // decoration: TextDecoration.underline,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
