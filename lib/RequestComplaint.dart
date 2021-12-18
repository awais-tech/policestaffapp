import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/ComplaintsFeedback.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/ViewDetailsofComplaints.dart';
import 'package:policesfs/maps.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'PoliceSFSDutiesProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestComplaint extends StatefulWidget {
  static final routeName = 'ViewRequestWorking';

  @override
  _RequestComplaintState createState() => _RequestComplaintState();
}

class _RequestComplaintState extends State<RequestComplaint> {
  final stream = FirebaseFirestore.instance
      .collection('Complaints')
      .where('status', isEqualTo: 'Request')
      .where('PoliceStationName',
          isEqualTo: json.decode(
              Constants.prefs.getString('userinfo') as String)['Division'])
      .snapshots();

  final streams = FirebaseFirestore.instance
      .collection('Complaints')
      .where('status', isEqualTo: 'Request')
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
                                              (snp.data!.docs[i].data()
                                                  as Map)["Complaint Location"],
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
                                              child: Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                Complaintdetails
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
                                                  json.decode(Constants.prefs
                                                                      .getString(
                                                                          'userinfo')
                                                                  as String)[
                                                              'Role'] ==
                                                          "Police Inspector"
                                                      ? TextButton(
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                isScrollControlled:
                                                                    true,
                                                                builder:
                                                                    (context) {
                                                                  return editEmail(
                                                                      context,
                                                                      snp
                                                                          .data!
                                                                          .docs[
                                                                              i]
                                                                          .id);
                                                                });
                                                          },
                                                          child: Text(
                                                              'View Report'))
                                                      : Container(),
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
                          childAspectRatio: 3 / 2,
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

Widget editEmail(BuildContext context, String id) {
  print(id);
  var streams = FirebaseFirestore.instance
      .collection('ComplaintsReport')
      .doc(id)
      .snapshots();

  return StreamBuilder(
      stream: streams,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snp) {
        if (snp.hasError) {
          print(snp);
          return Center(
            child: Text("No Data is here"),
          );
        } else if (snp.hasData || snp.data != null) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Report'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        DateFormat('dd/MM/yyyy hh:mm')
                            .format((snp.data!.data() as Map)['Date'].toDate()),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Description:' +
                            ((snp.data!.data() as Map)['Description']),
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage((snp.data!.data() as Map)['Image']),
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                      vertical: 25,
                                      horizontal: MediaQuery.of(context)
                                              .size
                                              .width -
                                          MediaQuery.of(context).padding.top) *
                                  0.35),
                          backgroundColor: MaterialStateProperty.all(
                              Color(0xff8d43d6)), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed))
                              return Color(0xffB788E5); // <-- Splash color
                          }),
                        ),
                        child: FittedBox(
                          child: const Text(
                            "Mark as Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(FeedbacksC.routename,
                              arguments: {"status": "Complete", "id": id});
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                      vertical: 25,
                                      horizontal: MediaQuery.of(context)
                                              .size
                                              .width -
                                          MediaQuery.of(context).padding.top) *
                                  0.35),
                          backgroundColor: MaterialStateProperty.all(
                              Color(0xff8d43d6)), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed))
                              return Color(0xffB788E5); // <-- Splash color
                          }),
                        ),
                        child: FittedBox(
                          child: const Text(
                            "ReAssign Again",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pushNamed(FeedbacksC.routename,
                              arguments: {"status": "Working", "id": id});
                          // await FirebaseFirestore.instance
                          //     .collection("Duties")
                          //     .doc(id)
                          //     .update({
                          //   "status": "Working",
                          //   "Updation":
                          //       "Report is not correct as duty assign Please attach the correct report again"
                          // });
                          // await FirebaseFirestore.instance
                          //     .collection("DutyReport")
                          //     .doc(id)
                          //     .delete();
                          // Navigator.of(context)
                          //     .pushNamed(PoliceDutiesStatus.routeName);
                          // return await showDialog(
                          //   context: context,
                          //   builder: (ctx) => AlertDialog(
                          //     title: Text('Update'),
                          //     content: Text("Status Update"),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         child: Text('Ok'),
                          //         onPressed: () {
                          //           Navigator.of(ctx).pop(false);
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                      )),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
          ),
        );
      });
}
