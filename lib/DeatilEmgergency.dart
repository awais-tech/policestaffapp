// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AssignComplaints.dart';
import 'package:policesfs/Userdetail.dart';

// ignore: camel_case_types
class DetailEmergency extends StatelessWidget {
  static final routename = "DetailEmergency";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final dat = ModalRoute.of(context)?.settings.arguments as Map;
    final datas = dat["data"];
    final ids = dat["id"];

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Emergency Complaints Details")),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: duplicate_ignore
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  Text(
                    datas['Title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // ignore: prefer_const_constructors
                  Text(
                    'Category:${datas['Catagory']}',
                    style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text("sub category:${datas['sub category']}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Text("sent by:${datas['sent by']}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Text("Type:${datas['Type']}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),

                  Text("Status: ${datas['status']}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),

                  Text(
                      "Date Created:  ${DateTime.parse(datas["date"].toDate().toString()).toString()}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Divider(
                    color: Colors.black,
                  ),

                  Text("Complainer Phone no:  ${datas["phone"]}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),

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
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: Colors.blue[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage('assets/Images/Logo.png'),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      datas['status'] == "pending"
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: Text("Approve",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                onPressed: () async {
                                  await _firestore
                                      .collection("Emergency")
                                      .doc(ids)
                                      .update({"status": "Approve"});
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Update'),
                                      content: Text("APPROVED"),
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
                                        MaterialStateProperty.all(Colors.black),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(10)),
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(fontSize: 16))),
                              ),
                            )
                          : Container(),
                      datas['status'] == "pending"
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: Text("Delete",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                onPressed: () async {
                                  await _firestore
                                      .collection("Emergency")
                                      .doc(ids)
                                      .delete();
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Update'),
                                      content: Text("Complaints is deleted"),
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
                                        MaterialStateProperty.all(Colors.black),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(10)),
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(fontSize: 16))),
                              ),
                            )
                          : Container(),
                      datas['Userid'] != "without login"
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
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
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
