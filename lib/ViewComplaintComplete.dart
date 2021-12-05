import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/ViewDetailsofComplaints.dart';
import 'package:policesfs/maps.dart';
import 'package:provider/provider.dart';
import 'PoliceSFSDutiesProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewComplaintsComplete extends StatefulWidget {
  static final routeName = 'ViewComplaintsComplete';

  @override
  _ViewComplaintsCompleteState createState() => _ViewComplaintsCompleteState();
}

class _ViewComplaintsCompleteState extends State<ViewComplaintsComplete> {
  final stream = FirebaseFirestore.instance
      .collection('Complaints')
      .where('status', isEqualTo: 'Complete')
      .snapshots();
  final streams = FirebaseFirestore.instance
      .collection('Complaints')
      .where('status', isEqualTo: 'Complete')
      .where('PoliceStationName',
          isEqualTo: json.decode(
              Constants.prefs.getString('userinfo') as String)['Division'])
      .where('PoliceOfficerid',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: json.decode(Constants.prefs.getString('userinfo')
                        as String)['Role'] ==
                    "Police Inspector"
                ? stream
                : streams,
            builder: (context, snp) {
              if (snp.hasError) {
                return Center(
                  child: Text("No Data is here"),
                );
              } else if (snp.hasData || snp.data != null) {
                return snp.data!.docs.length < 1
                    ? Center(child: Container(child: Text("No Complaints")))
                    : GridView.builder(
                        itemCount: snp.data!.docs.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 10,
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
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

                                                MapUtils.openMap(lat, long);
                                              },
                                              icon: Icon(Icons.map_outlined),
                                              label:
                                                  Text("Complainer Location"),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Status",
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
                                                  as Map)["status"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Priority",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "high",
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Center(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            Complaintdetails
                                                                .routename,
                                                            arguments: {
                                                          "data": (snp
                                                              .data!.docs[i]
                                                              .data()),
                                                          "id": snp
                                                              .data!.docs[i].id
                                                        });
                                                  },
                                                  child: Text('View Details')),
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
