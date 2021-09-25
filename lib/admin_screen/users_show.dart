import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time/Screens/HomeScreen1.dart';

class users_show extends StatefulWidget {
  final String doc_name;
  users_show(this.doc_name);

  @override
  _users_showState createState() => _users_showState();
}

class _users_showState extends State<users_show> {
  int send_units, recive_units;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Users",
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
            stream: Firestore.instance.collection(widget.doc_name).snapshots(),
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
                        username_sender: document['sender_username'],
                        username_reciver: document['reciver_username'],
                        email_sender: document['sender_email'],
                        email_reciver: document['reciver_email'],
                        units: document['send_money'],
                        reciver_uid: document['reciver'],
                        sender_uid: document['send'],
                        user_datails_byusername:
                            document['user_datails_by_username'],
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

  Widget ui(
      {username_sender,
      username_reciver,
      email_sender,
      email_reciver,
      units,
      reciver_uid,
      sender_uid,
      user_datails_byusername,
      user_datails_byemail,
      String id}) {
    return Column(
      children: [
        SizedBox(height: 20),
        ListTile(
          title: Text(
            user_datails_byusername,
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          subtitle: Text(user_datails_byemail),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                getdata(units, sender_uid, reciver_uid);
                setdata(units, sender_uid, reciver_uid, id, username_sender,
                    username_reciver);
                Firestore.instance.collection(widget.doc_name).document(id).delete();
              },
              child: Container(
                  height: 34,
                  width: 87,
                  color: Colors.deepOrange,
                  child: Center(
                    child: Text(
                      'Accept',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Firestore.instance
                    .collection(widget.doc_name)
                    .document(id)
                    .delete();
              },
              child: Container(
                height: 34,
                width: 87,
                color: Colors.deepOrange,
                child: Center(
                  child: Text(
                    'Canncel',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  getdata(units, sender_uid, reciver_uid) {
    Firestore.instance
        .collection('Users')
        .document(reciver_uid)
        .get()
        .then((DocumentSnapshot snap) {
      setState(() {
        recive_units = snap['units'];
        print(recive_units);
      });
    });
    Firestore.instance
        .collection('Users')
        .document(sender_uid)
        .get()
        .then((DocumentSnapshot snap) {
      setState(() {
        send_units = snap['units'];
        print(send_units);
      });
    });
    int final_sendunit = units - send_units;
    int final_reciveunit = recive_units + units;
    print(final_reciveunit);
    print(final_sendunit);
  }

  void setdata(units, sender_uid, reciver_uid, String id, username_sender,
      username_reciver) {
    if (widget.doc_name == 'sendmoney') {
      int final_sendunit = send_units - units;
      print('sendmoney');
      print(final_sendunit);
      int final_reciveunit = recive_units + units;
      print(final_reciveunit);
      print(final_sendunit);
      print(sender_uid);
      print(reciver_uid);
      Firestore.instance.collection('Users').document(sender_uid).updateData({
        'units': final_sendunit,
      });
      Firestore.instance.collection('Users').document(reciver_uid).updateData(
        {
          'units': final_reciveunit,
        },
      );
      Firestore.instance
          .collection('recent_notification')
          .document(reciver_uid)
          .collection('data')
          .document()
          .setData(
        {'units': units, 'name': username_sender},
      );
      Firestore.instance
          .collection('recent_notification')
          .document(sender_uid)
          .collection('data')
          .document()
          .setData(
        {'units': units, 'name': username_reciver},
      );
      Firestore.instance.collection(widget.doc_name).document(id).delete();
    } else {
      int final_sendunit = send_units + units;
      print('requestmoney');
      print(final_sendunit);
      int final_reciveunit = recive_units - units;
      Firestore.instance.collection('Users').document(sender_uid).updateData({
        'units': final_sendunit,
      });
      Firestore.instance.collection('Users').document(reciver_uid).updateData(
        {
          'units': final_reciveunit,
        },
      );
      Firestore.instance
          .collection('recent_notification')
          .document(reciver_uid)
          .collection('data')
          .document()
          .setData(
        {'units': units, 'name': username_sender},
      );
      Firestore.instance
          .collection('recent_notification')
          .document(sender_uid)
          .collection('data')
          .document()
          .setData(
        {'units': units, 'name': username_reciver},
      );
   
    }
  }
}
