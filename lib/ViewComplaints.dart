import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policestaffapp/ViewDetailsOfDuties.dart';
import 'package:policestaffapp/ViewDetailsofComplaints.dart';
import 'package:provider/provider.dart';
import 'PoliceSFSDutiesProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewComplaints extends StatefulWidget {
  static final routeName = 'ViewComplaints';

  @override
  _ViewComplaintsState createState() => _ViewComplaintsState();
}

class _ViewComplaintsState extends State<ViewComplaints> {
  final stream = FirebaseFirestore.instance
      .collection('Duties')
      .where('status', isEqualTo: 'Pending')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: stream,
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
                                  EdgeInsets.only(top: 30, left: 20, right: 20),
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
                          maxCrossAxisExtent: 338,
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