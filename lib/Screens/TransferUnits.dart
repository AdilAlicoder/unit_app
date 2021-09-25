import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time/Screens/AccountScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time/Screens/HomeScreen1.dart';

class TransferUnits extends StatefulWidget {
  const TransferUnits({Key key}) : super(key: key);

  @override
  _TransferUnitsState createState() => _TransferUnitsState();
}

class _TransferUnitsState extends State<TransferUnits> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _unitsController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String tranfer_units;
  String username;
  int units;
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
        email=snap['email'];
        username=snap['username'];
        units=snap['units'];
        tranfer_units=snap['units'].toString();
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
          "Transfer Funds",
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
                    "Enter Email Address",
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
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: "Enter Email", suffixIcon: Icon(Icons.edit)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black12,
              ),
              height: 60,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transfer Your units",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              // decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Balance : ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  // decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              tranfer_units,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  // decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                      height: 20,
                      width: 50,
                      child: TextFormField(
                        keyboardType:  TextInputType.number,
                        controller: _unitsController,
                        decoration: InputDecoration(
                          hintText: "0-1000",
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              // decoration: TextDecoration.underline,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 300,
            ),
            InkWell(
              onTap: () {
                send();
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
                      "Send",
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

  void send() {
    int unit_textfield = int.parse(_unitsController.text);
    if(unit_textfield>units){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
               'Error Message',style: TextStyle(fontSize: 20,color: Colors.white,),
              ),
              content: Text("Your Current Balance is $units", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            ),
          );
        },
      );
    }
    else {
      Fluttertoast.showToast(
          msg: "Sended units admin                    ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Firestore.instance
          .collection("Users")
          .get()
          .then((querySnapshot) =>
      {
        querySnapshot.docs.forEach((value) {
          Firestore.instance
              .collection('Users')
              .document(value.id)
              .get()
              .then((DocumentSnapshot snap) {
            if (snap['email'] == _usernameController.text) {
              String r_username = snap['username'];
              String r_email = snap['email'];
              Firestore.instance
                  .collection('sendmoney')
                  .document()
                  .setData({
                'send': uid,
                'reciver': value.id,
                'sender_username': username,
                'sender_email': email,
                'send_money': unit_textfield,
                'user_datails_by_username': '$username send $unit_textfield units $r_username',
                'user_datails_by_email': '$email send $unit_textfield units $r_email',
                'reciver_username': snap['username'],
                'reciver_email': snap['email'],
              });
            }
          });
        }),
      });
    }
  }
}
