// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AssignComplaints.dart';
import 'package:policesfs/ComplaintReport.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/Userdetail.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class Complaintdetails extends StatelessWidget {
  static final routename = "viewdetailComplaints";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final dat = ModalRoute.of(context)?.settings.arguments as Map;
    final datas = dat["data"];
    final ids = dat["id"];

    return Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text("Complaints Details")),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.star_border_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          backgroundColor: Colors.blue[900],
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: duplicate_ignore
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Card(
                            elevation: 40,
                            shadowColor: Colors.blueGrey,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Column(children: [
                                SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage("${datas['imageUrl']}"),
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  datas['Title'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),

                                // ignore: prefer_const_constructors
                                Text(
                                  'Category:${datas['Catagory']}',
                                  style: TextStyle(
                                      color: Colors.red[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 5),

                                Text("Sub-Category:${datas['sub category']}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(height: 5),

                                Text("Sent by:${datas['sent by']}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(height: 5),

                                Text("Type: ${datas['Type']}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(height: 5),

                                Text("Status: ${datas['status']}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(height: 5),

                                datas['ComplaintNo'] != "Not assign"
                                    ? Text(
                                        "Complaint No: ${datas['ComplaintNo']}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                    : Container(),
                                FittedBox(
                                  child: Text(
                                      "Date Created:  ${DateTime.parse(datas["date"].toDate().toString()).toString()}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                datas['status'] == "Working" ||
                                        datas['status'] == "Complete" ||
                                        datas['status'] == "Request"
                                    ? Text(
                                        'SHO ${datas['Assigned By'] ?? ""}Feedback:   ${datas['SHOFeedback'] ?? "No feedback"}',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                    : Container(),
                                datas["OfficerName"] != "No"
                                    ? Text(
                                        "Assigned To:  ${datas["OfficerName"]}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                    : Container(),
                                SizedBox(height: 5),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                      "Complainant Phone No:  ${datas["phone"]}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red[900])),
                                        onPressed: () async {
                                          try {
                                            var url = 'tel:${datas["phone"]}';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw url;
                                            }
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                        },
                                        child: FittedBox(
                                            child: Text("Call Complainant")))),
                                datas["Date Assigned"] != null
                                    ? Text(
                                        "Start Working On:  ${DateTime.parse(datas["Date Assigned"].toDate().toString()).toString()}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                    : Container(),

                                datas["DescriptionForOfficer"] != null
                                    ? Text(
                                        "Description for officer:  ${datas["DescriptionForOfficer"]}",
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                    : Container(),

                                Divider(
                                  color: Colors.black,
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                      "Report No:  ${datas["ReportNo"] ?? "No Report No"}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),

                                Divider(
                                  color: Colors.black,
                                ),
                                Text("Description",
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22)),
                                Text("${datas['Description']}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),

                                // ignore: prefer_const_constructors
                                SizedBox(
                                  height: 10,
                                ),
                                datas["status"] == "Complete"
                                    ? datas["Ufeedback"] != ""
                                        ? Text(
                                            "User Feedback:  ${datas["Ufeedback"]}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                        : Container()
                                    : Container(),
                              ]),
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      color: Colors.blue[900],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: AssetImage('assets/Images/Logo.png'),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          SizedBox(width: 10),
                          json.decode(Constants.prefs.getString('userinfo')
                                      as String)['Role'] ==
                                  "Police Inspector"
                              ? datas['status'] == "pending"
                                  ? ElevatedButton(
                                      child: FittedBox(
                                        child: Text('Assign Complaint',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pushNamed(
                                            AssignComplaintsScreen.routename,
                                            arguments: ids);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(10)),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(fontSize: 16))),
                                    )
                                  : Container(
                                      child: FittedBox(
                                          child: Text(
                                      "Complaint has been assigned ",
                                      softWrap: true,
                                    )))
                              : Container(),
                          json.decode(Constants.prefs.getString('userinfo')
                                      as String)['Role'] !=
                                  "Police Inspector"
                              ? datas['status'] == "Active" ||
                                      datas['status'] == "assigned"
                                  ? ElevatedButton(
                                      child: FittedBox(
                                        child: Text(
                                            '${datas['status']}' == "assigned"
                                                ? "accept Complaint"
                                                : "Complete Request ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                      onPressed: () async {
                                        datas['status'] == "assigned"
                                            ? await _firestore
                                                .collection("Complaints")
                                                .doc(ids)
                                                .update({"status": "Active"})
                                            : Navigator.of(context).pushNamed(
                                                ComplaintReport.routename,
                                                arguments: ids);
                                        ;
                                        return showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text('Update'),
                                            content: Text(
                                              '${datas['status']}' == "assigned"
                                                  ? "Start Working"
                                                  : "Request sent",
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(10)),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(fontSize: 16))),
                                    )
                                  : Container()
                              : Container(),
                          ElevatedButton(
                            child: FittedBox(
                              child: Text('User Detail',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pushNamed(
                                  UserDetail.routename,
                                  arguments: datas['Userid']);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 16))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
