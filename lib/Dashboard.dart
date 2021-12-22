import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddDuties.dart';
import 'package:policesfs/ComplaintTabbar.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/Policetabbar.dart';
import 'package:policesfs/ViewComplaints.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/drawner/drawner.dart';

class Staffdashboard extends StatelessWidget {
  static const routeName = '/Dashboard';
  final _auth = FirebaseAuth.instance;
  final List<String> navigators = [
    "Home",
    "Crime Record",
    "Jail Record",
  ];
  @override
  Widget build(BuildContext context) {
    print(Constants.prefs.getBool("login"));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: FittedBox(
              fit: BoxFit.fitWidth, child: Text('Police Staff Dashboard')),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                await Constants.prefs.remove('userData');
                await Constants.prefs.remove('userinfo');
                await Constants.prefs.setBool('login', false);
                await _auth.signOut();
                Navigator.of(context).pushNamed('/');
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(width: 1, color: Colors.black38)),
                backgroundColor: MaterialStateProperty.all(Colors.red[900]),
              ),
              child: FittedBox(fit: BoxFit.fitWidth, child: Text('Logout')),
            ),
          ],
        ), //AppBar
        drawer: Drawner(navigators: navigators),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return Center(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      json.decode(Constants.prefs.getString('userinfo')
                                  as String)['Role'] ==
                              "Police Inspector"
                          ? Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    tileColor: Colors.blueGrey[50],
                                    onTap: () {},
                                    title: Text(
                                      "Hi, Officer",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "To Assign Duties, Press '+' Button.",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () => {
                                              Navigator.of(context).pushNamed(
                                                  AddDutiesScreen.routename)
                                            },
                                        icon: Icon(
                                          Icons.add,
                                          size: 36,
                                        ))),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: constraints.maxHeight * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            color: Colors.pink,
                            elevation: 8,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(PoliceDutiesStatus.routeName);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.task_rounded,
                                    size: 75,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Duties",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ), //BoxDecoration
                        ), //Container
                      ), //Flexible
                      SizedBox(
                        width: 20,
                      ),
                      //Flexible

                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: constraints.maxHeight * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            elevation: 8,
                            color: Colors.amber[400],
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(PolicsComplaintStatus.routeName);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.poll_rounded,
                                    size: 75,
                                  ),
                                  Text(
                                    "Complaints",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ), //BoxDecoration
                          ),
                        ),
                      ), //Container
                    ],
                  ),
                  //Row
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          width: 380,
                          height: constraints.maxHeight * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            elevation: 8,
                            color: Colors.pink[200],
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.checklist_rtl_rounded,
                                    size: 75,
                                  ),
                                  Text(
                                    "Attendance",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ), //BoxDecoration
                        ), //Container
                      ),
                    ],
                  ), //Flexible
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          width: 180,
                          height: constraints.maxHeight * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            elevation: 8,
                            color: Colors.cyanAccent[400],
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 75,
                                  ),
                                  Text(
                                    "Chat with\nOperator",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ), //BoxDecoration
                        ),
                        //Container
                      ), //Flexible
                      SizedBox(
                        width: 20,
                      ), //SixedBox
                      Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Container(
                            width: 180,
                            height: constraints.maxHeight * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 8,
                              color: Colors.deepOrange[700],
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.auto_graph,
                                      size: 75,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Progess\nStatistics",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ), //BoxDecoration
                          ) //Container,
                          ) //Flexible
                    ], //<widget>[]
                    mainAxisAlignment: MainAxisAlignment.center,
                  ), //Row
                ], //<Widget>[]
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ), //Column
            ) //Padding
                ), //Container
          );
        }) //Center
        ); //Scaffold
  }
}
