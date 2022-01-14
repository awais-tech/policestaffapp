import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/Chat/OperatorChat.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/DeatilEmgergency.dart';
import 'package:policesfs/DetailsSPam.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/ViewDetailsofComplaints.dart';
import 'package:policesfs/maps.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyApprove extends StatefulWidget {
  static final routeName = 'EmergencyApprove';

  @override
  _EmergencyApproveState createState() => _EmergencyApproveState();
}

class _EmergencyApproveState extends State<EmergencyApprove> {
  final stream = FirebaseFirestore.instance
      .collection('Emergency')
      .where('status', isNotEqualTo: 'pending')
      .where('PoliceStationName',
          isEqualTo: json.decode(
              Constants.prefs.getString('userinfo') as String)['Division'])
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snp) {
              if (snp.hasError) {
                return Center(
                  child: Text("No Complaint is here"),
                );
              } else if (snp.hasData || snp.data != null) {
                return snp.data!.docs.length < 1
                    ? Center(child: Container(child: Text("No Complaints")))
                    : GridView.builder(
                        itemCount: snp.data!.docs.length,
                        itemBuilder: (context, i) {
                          return Card(
                            margin: EdgeInsets.all(20),
                            elevation: 20,
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Title",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              (snp.data!.docs[i].data()
                                                  as Map)["Title"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Catagory",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              (snp.data!.docs[i].data()
                                                  as Map)["Catagory"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Location",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              (snp.data!.docs[i].data()
                                                  as Map)["Complaint Location"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                String map = (snp.data!.docs[i]
                                                            .data() as Map)[
                                                        "Complaint Location"]
                                                    as String;
                                                var maps = map.split(",");
                                                var lat = double.parse(maps[0]);
                                                ;
                                                var long =
                                                    double.parse(maps[1]);
                                                ;

                                                MapUtils.openMap(lat, long);
                                              },
                                              icon: Icon(Icons.map_outlined),
                                              label:
                                                  Text("Complainer Location"),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                DetailEmergency
                                                                    .routename,
                                                                arguments: {
                                                              "data": (snp
                                                                  .data!.docs[i]
                                                                  .data()),
                                                              "id": snp.data!
                                                                  .docs[i].id
                                                            });
                                                      },
                                                      child:
                                                          Text('View Details')),
                                                  (snp.data!.docs[i].data()
                                                                  as Map)[
                                                              "Userid"] !=
                                                          "without login"
                                                      ? TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    OperatorChat
                                                                        .routeName,
                                                                    arguments: {
                                                                  "receiverid": (snp
                                                                          .data!
                                                                          .docs[i]
                                                                          .data()
                                                                      as Map)["Userid"],
                                                                  "senderid":
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid,
                                                                });
                                                          },
                                                          child: Text('Chat'))
                                                      : Text(
                                                          "User not have an account"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 450,
                          // MediaQuery.of(context).size.width /
                          // (MediaQuery.of(context).size.height / 1.4)
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ));
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                ),
              );
            }));
  }
}
