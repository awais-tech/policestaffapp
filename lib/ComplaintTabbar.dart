import 'package:flutter/material.dart';
import 'package:policestaffapp/ViewComplaints.dart';
import 'package:policestaffapp/ViewComplaintsassigned.dart';
import 'package:policestaffapp/ViewDuties.dart';
import 'package:policestaffapp/ViewDutiesComplete.dart';
import 'package:policestaffapp/ViewDutiesWorking.dart';

class PolicsComplaintStatus extends StatelessWidget {
  static final routeName = 'Track';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Check All Complaints',
                textAlign: TextAlign.center,
              ),
            ),
            bottom: TabBar(
              tabs: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.pending_actions),
                      text: "Approve Complaints"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.assignment), text: "Assigned Complaint"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(icon: Icon(Icons.work), text: "Working"),
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
              ViewComplaints(),
              ViewComplaintsassigned(),
              ViewComplaintsassigned(),
              ViewComplaintsassigned(),
            ],
          ),
        ),
      ),
    );
  }
}
