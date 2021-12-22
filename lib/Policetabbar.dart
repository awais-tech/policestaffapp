import 'package:flutter/material.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/ViewDutiesComplete.dart';
import 'package:policesfs/ViewDutiesRequest.dart';
import 'package:policesfs/ViewDutiesWorking.dart';

class PoliceDutiesStatus extends StatelessWidget {
  static final routeName = 'Track Complaint';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Container(
              padding: EdgeInsets.only(top: 40, bottom: 30, left: 30),
              width: double.infinity,
              child: Text(
                'Check All Duties',
                style: TextStyle(fontSize: 24),
              ),
            ),
            bottom: TabBar(
              tabs: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.pending_actions),
                      text: "Duties Not\nAccepted Yet"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(icon: Icon(Icons.work), text: "Working"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(icon: Icon(Icons.request_page), text: "Request"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.done_all), text: "Completed\nDuties"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ViewDuties(),
              ViewDutiesWorking(),
              ViewDutiesRequest(),
              ViewDutiesComplete(),
            ],
          ),
        ),
      ),
    );
  }
}
