import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen1.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen(
      {Key key,
      menuScreenContext,
      Null Function() onScreenHideButtonPressed,
      bool hideStatus})
      : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String uid;
  String name;
  String  units;
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

        units= snap['units'].toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                    width: 90,
                  ),
                  Text(
                    "Transactions",
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
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hi, $name!",
                  style: GoogleFonts.poppins(
                      color: Color(0xff5E17EB),
                      // decoration: TextDecoration.underline,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hope You are doing well! Today",
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      // decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 170,
            width: 340,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("Assets/Images/trans.png"))),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    children: [
                      Text(
                        "Your Current Balance",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    children: [
                      Text(
                        units,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontSize: 23,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "units",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "Assets/Images/Group 1.png",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Account Summary",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0),
            child: Row(
              children: [
                Text(
                  "Recent Notifications",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      // decoration: TextDecoration.underline,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('recent_notification').document(uid).collection('data').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              }
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: snapshot.data.documents
                      .map<Widget>((DocumentSnapshot document) {
                    return ui(
                        username: document['name'],
                        units: document['units'],
                        id: document.documentID);
                  }).toList(),
                ),
              );
            },
          ),

        ],
      ),
    ));
  }

  Widget ui({username, units, String id}) {
    String u_nits=units.toString();
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
          height: 90,
          width: 370,
          child: Card(
            elevation: 6,
            color: Color(0xff1CA20A),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        border: Border.all(width: 2, color: Colors.white)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    "Assets/Images/drawerProfle.png",
                    height: 50,
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              // decoration: TextDecoration.underline,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "You Send Units To Ali",
                          style: GoogleFonts.poppins(
                              color: Colors.white54,
                              // decoration: TextDecoration.underline,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset("Assets/Images/Layer 11.png"),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    u_nits,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        // decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
