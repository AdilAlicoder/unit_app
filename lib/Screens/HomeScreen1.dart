import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:time/Screens/AccountScreen.dart';
import 'package:time/Screens/AddUnit.dart';
import 'package:time/Screens/LoginScreen.dart';
import 'package:time/Screens/MessagesScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time/Screens/SendRequest.dart';
import 'package:time/Screens/SettingsScreen.dart';
import 'package:time/Screens/TransactionsScreen.dart';
import 'package:time/Screens/TransferUnits.dart';
import 'package:time/admin_screen/admin_home.dart';
import 'package:time/Utils/SizeConfiq.dart';
import 'package:drawer_swipe/drawer_swipe.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1(
      {Key key,
      menuScreenContext,
      bool hideStatus,
      Null Function() onScreenHideButtonPressed})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
//final _advancedDrawerController = AdvancedDrawerController();
  var drawerKey = GlobalKey<SwipeDrawerState>();
  String uid;
  String name;
  String email;
  String units;
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
        email = snap['email'];
        units = snap['units'].toString();
      });
    });
  }
// void _handleMenuButtonPressed() {
//     // NOTICE: Manage Advanced Drawer state through the Controller.
//     // _advancedDrawerController.value = AdvancedDrawerValue.visible();
//     _advancedDrawerController.showDrawer();
//   }

  Widget buildDrawer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Container(
                child: Image.asset("Assets/Images/drawerProfle.png"),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        // decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    email,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        // decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 1.5,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              onTap: () => selectedItem(context, 1),
              leading: Image.asset(
                "Assets/Images/dIcon1.png",
                height: 30,
                width: 30,
              ),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              onTap: () => selectedItem(context, 2),
              leading: Image.asset(
                "Assets/Images/dIcon2.png",
                height: 30,
                width: 30,
              ),
              title: Text(
                'Messages',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              onTap: () => selectedItem(context, 3),
              leading: Image.asset(
                "Assets/Images/dIcon3.png",
                height: 30,
                width: 30,
              ),
              title: Text(
                'Transaction History',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              onTap: () => selectedItem(context, 4),
              leading: Image.asset(
                "Assets/Images/dIcon4.png",
                height: 30,
                width: 30,
              ),
              title: Text(
                'Settings',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              onTap: () => selectedItem(context, 5),
              leading: Image.asset(
                "Assets/Images/dIcon5.png",
                height: 30,
                width: 30,
              ),
              title: Text(
                'My Account',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ListTile(
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (ctx) => Container(
                          height: 300,
                          width: 230,
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Text(
                              "Log Out?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                              "Are You Sure Want To Sign Out?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 0.0),
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    color: Color(0xff209CEE),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    color: Color(0xff209CEE),
                                    child: FlatButton(
                                      onPressed: () {
                                         Navigator.of(ctx).pop();
                                         
                                      pushNewScreen(context, withNavBar: false, screen: LoginScreen());
                                      },
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              },
              leading: Icon(
                Icons.logout,
                color: Colors.white60,
                size: 30,
              ),
              title: Text(
                "Log Out",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,

        hasClone: false,
        bodyBackgroundPeekSize: 30,
        backgroundColor: Color(0xff5E17EB),
        // pass drawer widget
        drawer: buildDrawer(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //   Image.asset("Assets/Images/HamBurger.png",height: 20,width: 20,),
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        if (drawerKey.currentState.isOpened()) {
                          drawerKey.currentState.closeDrawer();
                        } else {
                          drawerKey.currentState.openDrawer();
                        }
                      },
                    ),
                    Text("Home",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            // decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesScreen()));
                      },
                      child: Image.asset(
                        "Assets/Images/Notifications.png",
                        height: 25,
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(children: [
                Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xff5E17EB),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(110),
                          bottomRight: Radius.circular(110))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(33)),
                              child: Image.asset("Assets/Images/Wallet.png"),
                            ),
                            Text(
                              "My Wallet",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  // decoration: TextDecoration.underline,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: 4,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Units",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                      units,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.only(top: 70,right: 40,left: 40),
                  //   child: Positioned(child: Card()),
                  // ),
                ),
                Positioned(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(top: 100.0, left: 25, right: 25),
                  child: Container(
                    height: 310,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 6,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Send and Request",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    // decoration: TextDecoration.underline,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => TransferUnits()));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Color(0xff5E17EB),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          "Assets/Images/hand.png",
                                          height: 45,
                                          width: 45,
                                        ),
                                      )),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Pay',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => SendRequest()));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Color(0xff5E17EB),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          "Assets/Images/hand.png",
                                          height: 45,
                                          width: 45,
                                        ),
                                      )),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Money Transfer',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 27.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => AddUnit()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Color(0xff5E17EB),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image.asset(
                                            "Assets/Images/Layer 7.png",
                                            height: 45,
                                            width: 45,
                                          ),
                                        )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Add money',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ]),
              SizedBox(
                height: 10,
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
                stream: Firestore.instance
                    .collection('recent_notification')
                    .document(uid)
                    .collection('data')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
        ),
      ),
    );
  }

  Widget ui({username, units, String id}) {
    String u_nits = units.toString();
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
                  Icon(
                    Icons.person_rounded,
                    size: 30,
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

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen1()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MessagesScreen()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransactionScreen()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingScreen()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AccountScreen()));
        break;
    }
  }
}
