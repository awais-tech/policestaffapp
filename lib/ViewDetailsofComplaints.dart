// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policestaffapp/AssignComplaints.dart';

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
        title: Text("Complaints Details"),
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
                  'Category:${datas['Category']}',
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
                Text(
                    "Date Created:  ${DateTime.parse(datas["date"].toDate().toString()).toString()}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Divider(
                  color: Colors.black,
                ),
                Text("Complainer Phone no:  ${datas["Phone"]}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
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
              height: 140,
              width: double.infinity,
              color: Colors.blue[900],
              child: Row(
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
                  SizedBox(width: 15),
                  ElevatedButton(
                    child: Text('Assign Complaint',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    onPressed: () async {
                      Navigator.of(context)
                          .pushNamed(AssignComplaintsScreen.routename);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 16))),
                  ),
                  ElevatedButton(
                    child: Text('Complete Duty',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    onPressed: () async {
                      await _firestore
                          .collection("Duties")
                          .doc(ids)
                          .update({"status": "Complete"});
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Dutie update'),
                          content: Text(
                            'Mark as Complete',
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
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 16))),
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
