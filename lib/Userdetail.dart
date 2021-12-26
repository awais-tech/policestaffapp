// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AssignComplaints.dart';
import 'package:policesfs/ComplaintReport.dart';
import 'package:policesfs/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class UserDetail extends StatelessWidget {
  static final routename = "UserDetail";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final dat = ModalRoute.of(context)?.settings.arguments as String;
    var queryuser = _firestore.collection("user").doc(dat).snapshots();
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text("User Details")),
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
                        child: StreamBuilder(
                            stream: queryuser,
                            builder: (context, AsyncSnapshot snp) {
                              if (snp.hasError) {
                                return Center(
                                  child: Text("No Data is here"),
                                );
                              } else if (snp.hasData || snp.data != null) {
                                var datas = snp.data.data();

                                return Card(
                                    elevation: 40,
                                    shadowColor: Colors.blueGrey,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Column(children: [
                                        SizedBox(height: 10),

                                        SizedBox(height: 10),
                                        Text(
                                          datas['address'],
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),

                                        // ignore: prefer_const_constructors
                                        Text(
                                          'Age:${datas['age']}',
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(height: 5),

                                        Text("Email:${datas['email']}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SizedBox(height: 5),

                                        Text("Name:${datas['name']}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SizedBox(height: 5),

                                        Text("Area: ${datas['area']}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SizedBox(height: 5),

                                        Text("houseNo: ${datas['houseNo']}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SizedBox(height: 5),

                                        Divider(
                                          color: Colors.black,
                                        ),

                                        SizedBox(height: 5),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                              "Phone No:  ${datas["phoneno"]}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    )),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .red[900])),
                                                onPressed: () async {
                                                  try {
                                                    var url =
                                                        'tel:${datas["phoneno"]}';
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
                                                    child: Text(
                                                        "Call Complainant")))),

                                        // ignore: prefer_const_constructors
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ]),
                                    ));
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orangeAccent),
                                ),
                              );
                            }),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
