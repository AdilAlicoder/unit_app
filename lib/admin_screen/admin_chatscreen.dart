import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
class admin_chatscreen extends StatefulWidget {
  final String id,users;
  admin_chatscreen(this.id,this.users);


  @override
  _admin_chatscreenState createState() => _admin_chatscreenState();
}

class _admin_chatscreenState extends State<admin_chatscreen> {
  ScrollController _scrollController = ScrollController();
  FocusNode focusNode = new FocusNode();
  TextEditingController messageEditingController = new TextEditingController();
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
              widget.users,
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
                    .document(widget.id)
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
  Widget ui({message, sendby}) {
    if(sendby=='admin') {
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
    else{
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
  }
  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Firestore.instance.collection('admin_chatroom').document(widget.id).setData({
        "sendBy": widget.users,
      });
      Firestore.instance
          .collection('chatroom')
          .document(widget.id)
          .collection('chats')
          .document()
          .setData({
        "sendBy": 'admin',
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
      setState(() {
        messageEditingController.text = "";
      });
    }
  }
}
