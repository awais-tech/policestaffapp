import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/Chat/OperatorChat.dart';
import 'package:policesfs/ViewPrisoner.dart';
import 'AddJailRecord.dart';

class Viewallusers extends StatefulWidget {
  final comp;
  static final routeName = 'Viewallusers';

  Viewallusers(this.comp);

  @override
  _ViewallusersState createState() => _ViewallusersState();
}

class _ViewallusersState extends State<Viewallusers> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(6),
      child: ListTile(
        leading: FittedBox(
          child: Text(
            'Username: ${widget.comp['SenderName']}',
            softWrap: true,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {
            var senderid = widget.comp["receiverid"] !=
                    FirebaseAuth.instance.currentUser!.uid
                ? widget.comp["receiverid"]
                : widget.comp["senderid"];

            // var receiverid = widget.comp["receiverid"];

            var ids = widget.comp.id;
            Navigator.of(context).pushNamed(OperatorChat.routeName, arguments: {
              "senderid": FirebaseAuth.instance.currentUser!.uid,
              "receiverid": senderid,
            });
          },
        ),
      ),
    );
  }
}
