// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/DutyReport.dart';

// ignore: camel_case_types
class dutydetails extends StatefulWidget {
  static final routename = "viewdetailsdes";

  @override
  State<dutydetails> createState() => _dutydetailsState();
}

class _dutydetailsState extends State<dutydetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var name;

  @override
  Widget build(BuildContext context) {
    final dat = ModalRoute.of(context)?.settings.arguments as Map;

    final datas = dat["data"];
    final ids = dat["id"];

    _firestore
        .collection('PoliceStaff')
        .doc(datas["PoliceStaffid"])
        .get()
        .then((val) {
      name = (val.data() as Map)["Name"];
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Duty Details")),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: duplicate_ignore
          children: [
            Card(
              margin: EdgeInsets.all(20),
              elevation: 40,
              shadowColor: Colors.blueGrey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage('assets/Images/crime.jpg'),
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      datas['Title'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),

                    // ignore: prefer_const_constructors
                    Text(
                      'Category:${datas['Category']}',
                      style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: 5),

                    Text("Priority:${datas['Priority']}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 5),

                    Text("Location:${datas['Location']}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 5),

                    Text("Assign By: ${datas['Assign by']}",
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
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                          "Date Created:  ${DateTime.parse(datas["Date Created"].toDate().toString()).toString()}",
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
                            'SHO ${datas['Assign by']} Feedback:   ${datas['SHOFeedback'] ?? "No feedback"}',
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))
                        : Container(),

                    Text("Officer Name:  ${name}",
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
                    SizedBox(height: 5),

                    Text("${datas['Description']}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
              ),
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
                  json.decode(Constants.prefs.getString('userinfo') as String)[
                              'Role'] !=
                          "Police Inspector"
                      ? datas['status'] == "Pending"
                          ? ElevatedButton(
                              child: FittedBox(
                                child: Text('Accept Duty',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              onPressed: () async {
                                await _firestore
                                    .collection("Duties")
                                    .doc(ids)
                                    .update({"status": "Working"});
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Duty update'),
                                    content: Text(
                                      'Mark as Working',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop(false);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                                ;
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10)),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 16))),
                            )
                          : Container()
                      : Container(),
                  json.decode(Constants.prefs.getString('userinfo') as String)[
                              'Role'] !=
                          "Police Inspector"
                      ? datas['status'] == "Working"
                          ? FittedBox(
                              child: ElevatedButton(
                                child: FittedBox(
                                  child: Text('Request for complete',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pushNamed(
                                      DutyReport.routename,
                                      arguments: ids);
                                  // await _firestore
                                  //     .collection("Duties")
                                  //     .doc(ids)
                                  //     .update({"status": "Complete"});
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Upload Report'),
                                      content: Text(
                                        'Please Fill all details',
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
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(10)),
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(fontSize: 16))),
                              ),
                            )
                          : Container()
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, file_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // ignore: camel_case_types
// class dutydetails extends StatefulWidget {
//   static final routename = "viewdetailsdes";

//   @override
//   State<dutydetails> createState() => _dutydetailsState();
// }

// class _dutydetailsState extends State<dutydetails> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   var name;
//   var _isInit = true;

//   var loading = false;
//   var dat, datas, ids;
//   void didChangeDependencies() {
//     dat = ModalRoute.of(context)?.settings.arguments as Map;

//     datas = dat["data"];
//     ids = dat["id"];

//     if (_isInit) {
//       setState(() {
//         loading = true;
//       });

//       _firestore
//           .collection('PoliceStaff')
//           .doc(datas["PoliceStaffid"])
//           .get()
//           .then((val) {
//         name = (val.data() as Map)["Name"];

//         setState(() {
//           loading = true;
//         });
//       });

//       _isInit = false;

//       super.didChangeDependencies();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Duty Details"),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.star_border_outlined,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               // do something
//             },
//           )
//         ],
//         backgroundColor: Colors.blue[900],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // ignore: duplicate_ignore
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image(
//                     image: AssetImage('assets/Images/crime.jpg'),
//                     height: 100,
//                     width: double.infinity,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   datas['Title'],
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 // ignore: prefer_const_constructors
//                 Text(
//                   'Category:${datas['Category']}',
//                   style: TextStyle(
//                       color: Colors.red[900],
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//                 Text("Priority:${datas['Priority']}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                 Text("Location:${datas['Location']}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                 Text("Assign By: ${datas['Assign by']}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                 Text("Status: ${datas['status']}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                 Text(
//                     "Date Created:  ${DateTime.parse(datas["Date Created"].toDate().toString()).toString()}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                 Divider(
//                   color: Colors.black,
//                 ),
//                 Text("Officer Name:  ${name}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                 Divider(
//                   color: Colors.black,
//                 ),
//                 Text("Description",
//                     softWrap: true,
//                     style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22)),
//                 Text("${datas['Description']}",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//               ],
//             ),
//             // ignore: prefer_const_constructors
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 140,
//               width: double.infinity,
//               color: Colors.blue[900],
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Image(
//                       image: AssetImage('assets/Images/Logo.png'),
//                       height: 100,
//                       width: 100,
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   ElevatedButton(
//                     child: Text('Accept Duty',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16)),
//                     onPressed: () async {
//                       await _firestore
//                           .collection("Duties")
//                           .doc(ids)
//                           .update({"status": "Working"});
//                       showDialog(
//                         context: context,
//                         builder: (ctx) => AlertDialog(
//                           title: Text('Duty update'),
//                           content: Text(
//                             'Mark as Working',
//                           ),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text('Ok'),
//                               onPressed: () {
//                                 Navigator.of(ctx).pop(false);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                       ;
//                     },
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.black),
//                         padding: MaterialStateProperty.all(EdgeInsets.all(10)),
//                         textStyle:
//                             MaterialStateProperty.all(TextStyle(fontSize: 16))),
//                   ),
//                   ElevatedButton(
//                     child: Text('Complete Duty',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16)),
//                     onPressed: () async {
//                       await _firestore
//                           .collection("Duties")
//                           .doc(ids)
//                           .update({"status": "Complete"});
//                       return showDialog(
//                         context: context,
//                         builder: (ctx) => AlertDialog(
//                           title: Text('Dutie update'),
//                           content: Text(
//                             'Mark as Complete',
//                           ),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text('Yes'),
//                               onPressed: () {
//                                 Navigator.of(ctx).pop(false);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.black),
//                         padding: MaterialStateProperty.all(EdgeInsets.all(10)),
//                         textStyle:
//                             MaterialStateProperty.all(TextStyle(fontSize: 16))),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
