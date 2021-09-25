import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class admin_addunits extends StatefulWidget {

  @override
  _admin_addunitsState createState() => _admin_addunitsState();
}

class _admin_addunitsState extends State<admin_addunits> {
  int send_units;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('addmoney').snapshots(),
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
                        units: document['units'],
                        sender_uid:document['send'],
                        user_datails_byusername: document['user_datails_by_username'],
                        user_datails_byemail: document['user_datails_by_email'],
                        id: document.documentID);
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget ui({units, sender_uid, user_datails_byusername, user_datails_byemail, String id}) {
    return Column(
      children: [
        SizedBox(height:20),
        ListTile(
          title: Text(user_datails_byusername,style: TextStyle(fontSize: 17,color: Colors.black),),
          subtitle: Text(user_datails_byemail),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            RaisedButton(
              onPressed: (){
                getdata(units,sender_uid);
                setdata(units,sender_uid,id);
              },
              color: Colors.deepOrange,
              child:Text('Accept',style: TextStyle(fontSize: 15,color: Colors.white),
              ),
            ),
            RaisedButton(
              onPressed: (){
                Firestore.instance.collection('addmoney').document(id).delete();
              },
              color: Colors.deepOrange,
              child:Text('Canncel',style: TextStyle(fontSize: 15,color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
  getdata(units,sender_uid) {
    Firestore.instance
        .collection('Users')
        .document(sender_uid)
        .get()
        .then((DocumentSnapshot snap) {
      setState(() {
        send_units=snap['units'];
      });
    });
  }

  void setdata(units, sender_uid, String id) {
    int final_sendunit = send_units + units;
    Firestore.instance.collection('Users').document(sender_uid).updateData({
      'units': final_sendunit,
    });
    Firestore.instance.collection('addmoney').document(id).delete();
  }
}
