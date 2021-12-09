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
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: FittedBox(
                child: Text(
                  'Check All Duties',
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
                      text: "Duties not accepted yet"),
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
                  child:
                      Tab(icon: Icon(Icons.done_all), text: "Completed Duties"),
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
