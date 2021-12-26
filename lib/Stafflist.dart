// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/ComplaintspecficTabar.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/Dutyfeedback.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/maps.dart';
import 'package:policesfs/specficdutytabbar.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'PoliceSFSDutiesProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import

class StaffList extends StatefulWidget {
  static final routeName = 'StaffList';

  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  final stream = FirebaseFirestore.instance
      .collection('PoliceStaff')
      .where('PoliceStationID',
          isEqualTo: json.decode(
              Constants.prefs.getString('userinfo') as String)['StationId'])
      .where("PoliceStaffId",
          whereNotIn: [FirebaseAuth.instance.currentUser!.uid]).snapshots();

  @override
  Widget build(BuildContext context) {
    print(json
        .decode(Constants.prefs.getString('userinfo') as String)['StationId']);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: FittedBox(child: Text('Staff List')),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snp) {
              if (snp.hasError) {
                print(snp.error);
                return Center(
                  child: Text("No Data is here"),
                );
              } else if (snp.hasData || snp.data != null) {
                return GridView.builder(
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
                                        Text(
                                          "Name",
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
                                              as Map)["Name"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "CNIC",
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
                                              as Map)["CNIC"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Email",
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
                                              as Map)["Email"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (snp.data!.docs[i].data()
                                              as Map)["Gender"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (snp.data!.docs[i].data()
                                              as Map)["Nationality"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Role",
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
                                              as Map)["Role"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Column(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        builder: (context) {
                                                          return editEmail(
                                                              context,
                                                              snp.data!.docs[i]
                                                                  .id,
                                                              snp.data!
                                                                  .docs[i]);
                                                        });
                                                  },
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child:
                                                          Text('View Detail'))),
                                              TextButton(
                                                onPressed: () {
                                                  var id = snp.data!.docs[i].id;
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          SpecficTababar
                                                              .routeName,
                                                          arguments: id);
                                                },
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child:
                                                      Text('View Complaints'),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    var id =
                                                        snp.data!.docs[i].id;
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            specficduty
                                                                .routeName,
                                                            arguments: id);
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text('View Duties'),
                                                  )),
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
                      maxCrossAxisExtent: 440,
                      // MediaQuery.of(context).size.width /
                      // (MediaQuery.of(context).size.height / 1.4)
                      childAspectRatio: 1 / 1.3,
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

Widget editEmail(BuildContext context, String id, staff) {
  print(id);
  var streams = FirebaseFirestore.instance
      .collection('Complaints')
      .where('PoliceOfficerid', isEqualTo: id)
      .where('status', whereNotIn: ["pending", "disapprove"]).snapshots();

  return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('More Detail'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Date of Joinning: ${DateFormat('dd/MM/yyyy hh:mm').format((staff.data() as Map)['dateofJoining'].toDate())}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('PhoneNo:' + ((staff.data() as Map)['PhoneNo']),
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Address:' + ((staff.data() as Map)['Address']),
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage((staff.data() as Map)['imageUrl']),
                  height: 100,
                  width: double.infinity,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: streams,
                builder: (context, snp) {
                  if (snp.hasError) {
                    return Center(
                      child: Text("No More Data"),
                    );
                  } else if (snp.hasData || snp.data != null) {
                    var complete = snp.data!.docs
                        .where((val) =>
                            (val.data() as Map)["status"] == "Complete")
                        .toList();
                    var working = snp.data!.docs
                        .where((val) =>
                            (val.data() as Map)["status"] == "assigned")
                        .toList();
                    var completeTotal = complete.length;
                    var workingTotal = working.length;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                              'Solved Complaints:' + completeTotal.toString(),
                              softWrap: true,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Assigned Complaints:' + workingTotal.toString(),
                              softWrap: true,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    ),
                  );
                }),
          ],
        ),
      ));
}
