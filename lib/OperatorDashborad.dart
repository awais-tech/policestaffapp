import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddDuties.dart';
import 'package:policesfs/ChatUser.dart';
import 'package:policesfs/ComplaintTabbar.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/JailRecords.dart';
import 'package:policesfs/Policetabbar.dart';
import 'package:policesfs/Spamchecker.dart';
import 'package:policesfs/ViewComplaints.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/drawner/drawner.dart';

class Operatordashboard extends StatelessWidget {
  static const routeName = '/operatorDashboard';
  final _auth = FirebaseAuth.instance;
  static List<IconData> navigatorsIcon = [
    Icons.home,
    Icons.list_alt_rounded,
    Icons.list,
    Icons.report
  ];

  final List<String> navigators = ["Home", "Crime Record", "Staff List"];
  @override
  Widget build(BuildContext context) {
    print(Constants.prefs.getBool("login"));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: FittedBox(
              fit: BoxFit.fitWidth, child: Text('Police Operator Dashboard')),
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
        ),
        drawer: Drawner(navigators: navigators), //AppBar
        body: LayoutBuilder(builder: (ctx, constraints) {
          return Center(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: <Widget>[
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
                            elevation: 8,
                            color: Colors.amber[400],
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(OperatorStatus.routeName);
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
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(JailRecords.routeName);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.recent_actors_rounded,
                                    size: 75,
                                  ),
                                  Text(
                                    "Jail Record",
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
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ChatUser.routeName);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 75,
                                  ),
                                  Text(
                                    "Chat with User",
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
