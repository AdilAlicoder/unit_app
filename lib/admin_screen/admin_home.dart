import 'package:flutter/material.dart';
import 'users_show.dart';
import 'admin_addunits.dart';
import 'admin_chatscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
class admin_home extends StatefulWidget {

  @override
  _admin_homeState createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title:  Text(
          "Send and Request",
          style: GoogleFonts.poppins(
              color: Colors.black,
              // decoration: TextDecoration.underline,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => users_show('sendmoney')),
                  );
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
                    SizedBox(height:10),
                    Text('Pay user data',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => users_show('requestmoney')),
                  );
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
                    SizedBox(height:10),
                    Text('Money Transfer user data',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => admin_addunits()),
                    );
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
                                "Assets/Images/Group 6.png",
                                height: 45,
                                width: 45,
                              ),
                            )),
                      ),
                      SizedBox(height:10),
                      Text('Add money user data',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(child: Text('Chats',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('admin_chatroom').snapshots(),
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
                      users: document['sendBy'],
                      id:document.id,
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget ui({users, String id}) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        SizedBox(height:25),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => admin_chatscreen(id,users)),
              );
    },
              child: Text(users,style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold ),)),
        ),
      ],
    );
  }
}
