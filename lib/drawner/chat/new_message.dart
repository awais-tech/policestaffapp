import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
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
      'receiverid': 'BXwySkot9bw59oDsbhN',
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
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
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
