import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddJailCell.dart';
import 'package:policesfs/Allusers.dart';
import 'package:policesfs/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ViewJailCells.dart';
import 'dart:convert';

class ChatUser extends StatefulWidget {
  static final routeName = 'ChatUser';

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  String StationId = "";

  final stream = FirebaseFirestore.instance
      .collection('chat')
      .orderBy(
        'date',
        descending: true,
      )
      .snapshots();
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FittedBox(child: Text('Chat With users')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              SizedBox(
                width: 10,
              ), //
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (val) => setState(() {
                      name = val;
                    }),
                    decoration: InputDecoration(
                      fillColor: Colors.blueAccent[50],
                      filled: true,
                      labelText: 'Search by Person Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      labelStyle:
                          TextStyle(fontSize: 16.0, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snp) {
                  if (snp.hasError) {
                    print(snp);
                    return Center(
                      child: Text("No Data is here"),
                    );
                  } else if (snp.hasData || snp.data != null) {
                    var i = -1;
                    var all = snp.data?.docs
                        .where((elements) {
                          i = i + 1;
                          print(i);

                          return snp.data?.docs.indexWhere((ele) =>
                                  (elements.data() as Map)["senderid"] ==
                                  (ele.data() as Map)["senderid"]) ==
                              i;
                        })
                        .where((element) =>
                            (element.data() as Map)["senderid"] !=
                            FirebaseAuth.instance.currentUser!.uid)
                        .toList();

                    return all!.length < 1
                        ? Center(child: Container(child: Text("No Record")))
                        : ListView.builder(
                            itemCount: all.length,
                            itemBuilder: (ctx, i) => Container(
                                child: name != ""
                                    ? all[0]["SenderName"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                name.toString().toLowerCase())
                                        ? Viewallusers(all[i])
                                        : Container()
                                    : Viewallusers(all[i])));
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
