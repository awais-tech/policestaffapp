import 'dart:convert';

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:select_form_field/select_form_field.dart';

class EmergencyPending extends StatefulWidget {
  static final routeName = 'EmergencyPending';

  @override
  _EmergencyPendingState createState() => _EmergencyPendingState();
}

class _EmergencyPendingState extends State<EmergencyPending> {
  var _isInit = true;
  var loading = true;
  var _stationDivisions;
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        loading = true;
      });

      FirebaseFirestore.instance
          .collection('PoliceStation')
          .get()
          .then((result) {
        _stationDivisions = result.docs
            .map((val) => {
                  'label': val.data()["Division"],
                  "value": val.data()["Division"]
                })
            .toList();
      });
      setState(() {
        loading = false;
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  final stream = FirebaseFirestore.instance
      .collection('Emergency')
      .where('status', isEqualTo: 'pending')
      .where('PoliceStationName',
          isEqualTo: json.decode(
              Constants.prefs.getString('userinfo') as String)['Division'])
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
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
                                margin: EdgeInsets.all(20),
                                elevation: 20,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                          as Map)[
                                                      "Complaint Location"],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    String map = (snp
                                                                .data!.docs[i]
                                                                .data() as Map)[
                                                            "Complaint Location"]
                                                        as String;
                                                    var maps = map.split(",");
                                                    var lat =
                                                        double.parse(maps[0]);
                                                    ;
                                                    var long =
                                                        double.parse(maps[1]);
                                                    ;

                                                    MapUtils.openMap(lat, long);
                                                  },
                                                  icon:
                                                      Icon(Icons.map_outlined),
                                                  label: Text(
                                                      "Complainer Location"),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    DetailEmergency
                                                                        .routename,
                                                                    arguments: {
                                                                  "data": (snp
                                                                      .data!
                                                                      .docs[i]
                                                                      .data()),
                                                                  "id": snp
                                                                      .data!
                                                                      .docs[i]
                                                                      .id
                                                                });
                                                          },
                                                          child: Text(
                                                              'View Details')),
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
                                                                          .docs[
                                                                              i]
                                                                          .data() as Map)["Userid"],
                                                                      "senderid": FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid,
                                                                    });
                                                              },
                                                              child:
                                                                  Text('Chat'))
                                                          : Text(
                                                              "User not have an account"),
                                                      TextButton(
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                isScrollControlled:
                                                                    true,
                                                                builder:
                                                                    (context) {
                                                                  return changestatus(
                                                                      context,
                                                                      "Transfer",
                                                                      snp.data!
                                                                              .docs[
                                                                          i],
                                                                      snp.data!
                                                                          .docs[i],
                                                                      _stationDivisions);
                                                                });
                                                          },
                                                          child:
                                                              Text('Transfer'))
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
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
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

Widget changestatus(
    BuildContext context, String title, compl, station, _stationDivisions) {
  var statuschan = TextEditingController();
  statuschan.text = compl.data()["PoliceStationName"];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Transfer To Other Police Station'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: SelectFormField(
                onChanged: (val) => statuschan.text = val,
                labelText: 'Transfer To Other Police Station',
                type: SelectFormFieldType.dropdown,
                initialValue:
                    compl.data()["PoliceStationName"], // or can be dialog
                items: _stationDivisions,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).padding.top) *
                      0.35),
                  backgroundColor: MaterialStateProperty.all(
                      Colors.red[900]), // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xffB788E5); // <-- Splash color
                  }),
                ),
                child: const Text(
                  "Change",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await _firestore
                      .collection("Emergency")
                      .doc(compl.id)
                      .update({"PoliceStationName": statuschan.text});
                  return await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Transfer'),
                      content: Text("Status Update"),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                            Navigator.of(ctx).pop(false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    ),
  );
}
