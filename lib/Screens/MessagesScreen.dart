import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:time/Utils/database.dart';

import 'HomeScreen1.dart';

class MessagesScreen extends StatefulWidget {
  final String chatRoomId;
  final String username;
  const MessagesScreen(
      {Key key,
      menuScreenContext,
      bool hideStatus,
      Null Function() onScreenHideButtonPressed,
      this.chatRoomId,
      this.username})
      : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  FocusNode focusNode = new FocusNode();
  Stream<QuerySnapshot> chats;
  String uid;
  String admin = 'admin';
  String username;
  final FirebaseAuth auth = FirebaseAuth.instance;
  ScrollController _scrollController = ScrollController();
  TextEditingController messageEditingController = new TextEditingController();
  Future<void> currentuser() async {
    final User user = await auth.currentUser;
    Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot snap) {
      setState(() {
        uid = user.uid;
        username = snap['username'];
      });
    });
  }

  addMessage() {
    print(widget.chatRoomId);
    if (messageEditingController.text.isNotEmpty) {
      String doc = '$username _$admin';
      Firestore.instance.collection('admin_chatroom').document(doc).setData({
        "sendBy": username,
      });
      Firestore.instance
          .collection('chatroom')
          .document(doc)
          .collection('chats')
          .document()
          .setData({
        "sendBy": username,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    currentuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE4E4C9),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff8AF3D8),
              backgroundImage: AssetImage('Assets/Images/drawerProfle.png'),
              radius: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'adminuser',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
      ),
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.green,
              gradient: LinearGradient(
                colors: [
                  Color(0xffE4E4C9),
                  //   Color(0xff80CBCB),
                  Color(0xff80CBCB)
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              )),
          child: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('chatroom')
                    .document('$username _$admin')
                    .collection('chats')
                    .orderBy('time')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null) {
                    return CircularProgressIndicator();
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height/1.3,
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: snapshot.data.documents
                          .map<Widget>((DocumentSnapshot document) {
                        return ui(
                          message: document['message'],
                          sendby:document['sendBy'],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xffD9F1E8),
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 20),
                        child: Container(
                          height: 50,
                          width: 250,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            child: TextFormField(
                              focusNode: focusNode,
                              controller: messageEditingController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: InputBorder.none,
                                  hintText: "Type Here",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Image.asset("Assets/Icons/Icon awesome-microphone.png"),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            addMessage();
                            Timer(
                                Duration(milliseconds: 300),
                                () => _scrollController.jumpTo(_scrollController
                                    .position.maxScrollExtent));
                            focusNode.unfocus();
                          },
                          child: Icon(
                            Icons.send,
                            size: 30,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ui({message,sendby}) {
    if(sendby=='admin') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18,),
          Container(
            margin:  EdgeInsets.only(right: 30),
            padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                )),
            child: Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w400)),
          ),
        ],
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height:18),
          Container(
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23)),
                gradient: LinearGradient(
                  colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
                )),
            child: Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w400)),
          ),
        ],
      );
    }
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [Colors.white, Colors.white],
            )),
        child: InkWell(
          onTap: () {
            print('message');
          },
          child: Text(message,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
