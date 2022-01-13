import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:policesfs/CriminalRecords.dart';
import 'package:policesfs/Emergency.dart';
import 'package:policesfs/JailRecords.dart';
import 'package:policesfs/OperatorDashborad.dart';
import 'package:policesfs/Stafflist.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Drawner extends StatelessWidget {
  const Drawner({
    Key? key,
    required this.navigators,
  }) : super(key: key);

  final List<String> navigators;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: LayoutBuilder(builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: SharedPreferences
                    .getInstance(), // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<Widget> children = [Container(child: Text('email'))];
                  if (snapshot.hasData) {
                    var c = json
                        .decode(snapshot.data.getString('userinfo') as String);
                    children = <Widget>[
                      Container(
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: Colors.blue[900]),
                          accountEmail: Text(c['Email']),
                          accountName: Text(c['Name']),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                      )
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              ),
              Container(
                height: constraints.minHeight * 0.7,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: navigators.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 3),
                          child: ListTile(
                            onTap: () async {
                              if (navigators[index] == "Home") {
                                Navigator.of(context).pushReplacementNamed('/');
                              } else if (navigators[index] == "Crime Record") {
                                Navigator.of(context)
                                    .pushNamed(ComplaintEmergency.routeName);
                              } else if (navigators[index] == "Staff List") {
                                Navigator.of(context)
                                    .pushNamed(StaffList.routeName);
                              } else if (navigators[index] == "Emergency") {
                                Navigator.of(context)
                                    .pushNamed(Emergency.routeName);
                              }
                            },
                            leading: Icon(
                              Operatordashboard.navigatorsIcon[index],
                              color: Colors.blue[900],
                            ),
                            title: Text(
                              "${navigators[index]}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
