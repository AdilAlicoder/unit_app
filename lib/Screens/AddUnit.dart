import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time/Screens/HomeScreen1.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddUnit extends StatefulWidget {
  const AddUnit({Key key}) : super(key: key);

  @override
  _AddUnitState createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  TextEditingController _usernameController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String username;
  String email;
  @override
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
        email = snap['email'];
        username = snap['username'];
        uid = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Units",
          style: GoogleFonts.poppins(
              color: Colors.black,
              // decoration: TextDecoration.underline,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen1()));
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Text(
                    "Enter Units for add",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        // decoration: TextDecoration.underline,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: "Enter Units", suffixIcon: Icon(Icons.edit)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 350,
            ),

            InkWell(
              onTap: () {
                addunits();
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
                      "Done",
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
          ],
        ),
      ),
    );
  }

  void addunits() {
    Fluttertoast.showToast(
        msg: "Sended units admin                    ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    int unit_textfield = int.parse(_usernameController.text);
    Firestore.instance.collection('addmoney').document().setData({
      'send': uid,
      'sender_username': username,
      'user_datails_by_username': '$username request for add  $unit_textfield units',
      'user_datails_by_email': '$email request for add $unit_textfield units',
      'units':unit_textfield,
      'sender_email': email,
    });
  }
}
