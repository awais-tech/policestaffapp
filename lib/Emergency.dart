import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AssignComplaints.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/AddCriminalRecord.dart';
import 'package:policesfs/CriminalRecordView.dart';
import 'dart:convert';

import 'package:policesfs/EmergencyView.dart';

class Emergency extends StatefulWidget {
  static final routeName = 'CrimeRecord';

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  final stream =
      FirebaseFirestore.instance.collection('CriminalRecord').snapshots();
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FittedBox(child: Text('Criminal Record')),
      ),

      // body: StreamBuilder<List<ComplaintsModel>>(
      //   stream: complaints.allcomplaints,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       print(snapshot);
      //       return Center(
      //         child: Text("No Data is here"),
      //       );
      //     } else {
      //       final com = snapshot.data;
      //       return com!.isEmpty
      //           ? Center(
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: FittedBox(
      //                   fit: BoxFit.contain,
      //                   child: Text(
      //                     'Welcome! Pending Complaints will be shown here',
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //               ),
      //             )
      //           : ListView.builder(
      //               itemCount: snapshot.data!.length,
      //               itemBuilder: (ctx, i) =>
      //                   (snapshot.data![i].status == 'pending'
      //                       ? PendingCompalints(snapshot.data![i])
      //                       : Container()),
      //             );
      //     }
      //   },
      // ),
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
                      labelText: 'Search by Title',
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
                    return snp.data!.docs.length < 1
                        ? Center(child: Container(child: Text("No Record")))
                        : ListView.builder(
                            itemCount: snp.data!.docs.length,
                            itemBuilder: (ctx, i) => Container(
                                child: name != ""
                                    ? (snp.data!.docs[i].data() as Map)["Title"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                name.toString().toLowerCase())
                                        ? EmergencyView(snp.data!.docs[i])
                                        : Container()
                                    : EmergencyView(snp.data!.docs[i])));
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
