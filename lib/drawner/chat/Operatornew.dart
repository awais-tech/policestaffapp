import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Operatornew extends StatefulWidget {
  @override
  _OperatornewState createState() => _OperatornewState();
  var id;
  Operatornew(this.id);
}

class _OperatornewState extends State<Operatornew> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final shared = await SharedPreferences.getInstance();

    var data = shared.getString("userinfo");
    var name = json.decode(data!)["Name"];
    var StationId = json.decode(data!)["StationId"];
    // final userData = await FirebaseFirestore.instance
    //     .collection('users')
    //     .document(user.uid)
    //     .get();
    FirebaseFirestore.instance.collection('chat').add({
      'message': _enteredMessage,
      'date': Timestamp.now(),
      'senderid': FirebaseAuth.instance.currentUser!.uid,
      'receiverid': widget.id["receiverid"],
      'SenderName': name,
      'role': 'Police Officer',
      "Policestationid": StationId
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter Message Here...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Colors.red[900],
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
