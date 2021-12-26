// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/maps.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'PoliceSFSDutiesProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import

class PDutiesWorking extends StatefulWidget {
  static final routeName = 'PDutiesWorking';
  var id;
  PDutiesWorking(id);
  @override
  _PDutiesWorkingState createState() => _PDutiesWorkingState();
}

class _PDutiesWorkingState extends State<PDutiesWorking> {
  @override
  Widget build(BuildContext context) {
    final streams = FirebaseFirestore.instance
        .collection('Duties')
        .where('status', isEqualTo: 'Working')
        .where('PoliceStaffid', isEqualTo: widget.id)
        .snapshots();
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: streams,
            builder: (context, snp) {
              if (snp.hasError) {
                return Center(
                  child: Text("No Data is here"),
                );
              } else if (snp.hasData || snp.data != null) {
                return snp.data!.docs.length < 1
                    ? Center(child: Container(child: Text("No Duties")))
                    : GridView.builder(
                        itemCount: snp.data!.docs.length,
                        itemBuilder: (context, i) {
                          return Card(
                            margin: EdgeInsets.all(20),
                            elevation: 20,
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                              "Category",
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
                                                  as Map)["Category"],
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
                                            TextButton.icon(
                                              onPressed: () {
                                                String map =
                                                    (snp.data!.docs[i].data()
                                                            as Map)["Location"]
                                                        as String;

                                                MapUtils.launchMap(map);
                                              },
                                              icon: Icon(Icons.map_outlined),
                                              label: Text("Duty Location"),
                                            ),
                                            Text(
                                              (snp.data!.docs[i].data()
                                                  as Map)["Location"],
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
                                              (snp.data!.docs[i].data()
                                                  as Map)["Priority"],
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
                                                            dutydetails
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
