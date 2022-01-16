import 'package:flutter/material.dart';
import 'package:policesfs/Complaintsapprove.dart';
import 'package:policesfs/Complaintspamcheck.dart';
import 'package:policesfs/Screens/ManageAllEmergency/EmergencyApprove.dart';
import 'package:policesfs/Screens/ManageAllEmergency/EmergencyPending.dart';

import 'package:policesfs/ViewComplaintComplete.dart';
import 'package:policesfs/ViewComplaints.dart';
import 'package:policesfs/ViewComplaintsWorking.dart';
import 'package:policesfs/ViewComplaintsassigned.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/ViewDutiesComplete.dart';
import 'package:policesfs/ViewDutiesWorking.dart';

class OperatorEmergency extends StatelessWidget {
  static final routeName = 'OperatorEmergency';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: FittedBox(
                child: Text(
                  'View Emergency Complaints',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.pending_actions),
                      text: "Pending Complaints"),
                ),

                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.approval_rounded),
                      text: "Approve Complaints"),
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
              EmergencyPending(),
              EmergencyApprove(),
            ],
          ),
        ),
      ),
    );
  }
}
