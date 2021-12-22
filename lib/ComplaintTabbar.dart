import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/RequestComplaint.dart';
import 'package:policesfs/ViewComplaintComplete.dart';
import 'package:policesfs/ViewComplaints.dart';
import 'package:policesfs/ViewComplaintsWorking.dart';
import 'package:policesfs/ViewComplaintsassigned.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/ViewDutiesComplete.dart';
import 'package:policesfs/ViewDutiesWorking.dart';

class PolicsComplaintStatus extends StatelessWidget {
  static final routeName = 'Track';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: json.decode(
                    Constants.prefs.getString('userinfo') as String)['Role'] ==
                "Police Inspector"
            ? 5
            : 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: FittedBox(
                child: Text(
                  'Check All Complaints',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                if (json.decode(Constants.prefs.getString('userinfo')
                        as String)['Role'] ==
                    "Police Inspector")
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Tab(
                        icon: Icon(Icons.pending_actions),
                        text: "Approved\nComplaints"),
                  ),

                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.assignment),
                      text: "Assigned\nComplaint"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(icon: Icon(Icons.work), text: "Working"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(icon: Icon(Icons.work), text: "Request"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(icon: Icon(Icons.done_all), text: "Completed"),
                ),
                // FittedBox(
                //   fit: BoxFit.contain,
                //   child:
                //       Tab(icon: Icon(Icons.done_all), text: "Completed Duties"),
                // ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              if (json.decode(Constants.prefs.getString('userinfo') as String)[
                      'Role'] ==
                  "Police Inspector")
                ViewComplaints(),
              ViewComplaintsassigned(),
              ViewComplaintsWorking(),
              RequestComplaint(),
              ViewComplaintsComplete(),
            ],
          ),
        ),
      ),
    );
  }
}
