// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AssignComplaints.dart';
import 'package:policesfs/Userdetail.dart';

// ignore: camel_case_types
class detailsofSpam extends StatelessWidget {
  static final routename = "viewdetailspam";
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: duplicate_ignore
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text("Type: ${datas['Type']}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Text("Status: ${datas['status']}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                datas['ComplaintNo'] != "Not assign"
                    ? Text("Complaint No: ${datas['ComplaintNo']}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                    : Container(),
                Text(
                    "Date Created:  ${DateTime.parse(datas["date"].toDate().toString()).toString()}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Divider(
                  color: Colors.black,
                ),
                datas["OfficerName"] != "No"
                    ? Text("Assigned To:  ${datas["OfficerName"]}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                    : Container(),
                Text("Complainer Phone no:  ${datas["phone"]}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                datas["Date Assigned"] != null
                    ? Text(
                        "Start Working On:  ${DateTime.parse(datas["date"].toDate().toString()).toString()}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                    : Container(),

                datas["Description for officer"] != null
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
                Text("ReportNo:  ${datas["ReportNo"] ?? "No Report No"}",
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
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: Colors.blue[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage('assets/Images/Logo.png'),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(width: 15),
                  datas['status'] == "disapprove"
                      ? ElevatedButton(
                          child: Text("Approve",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          onPressed: () async {
                            await _firestore
                                .collection("Complaints")
                                .doc(ids)
                                .update({"status": "pending"});
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
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 16))),
                        )
                      : Container(),
                  datas['status'] == "disapprove"
                      ? ElevatedButton(
                          child: Text("Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          onPressed: () async {
                            await _firestore
                                .collection("Complaints")
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
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 16))),
                        )
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
                      Navigator.of(context).pushNamed(UserDetail.routename,
                          arguments: datas['Userid']);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 16))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
