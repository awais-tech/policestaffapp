import 'package:flutter/material.dart';
import 'package:policestaffapp/ViewDuties.dart';
import 'package:policestaffapp/ViewDutiesComplete.dart';
import 'package:policestaffapp/ViewDutiesWorking.dart';

class PoliceDutiesStatus extends StatelessWidget {
  static final routeName = 'Track Complaint';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Check All Duties',
                textAlign: TextAlign.center,
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
                  child:
                      Tab(icon: Icon(Icons.pending_actions), text: "Working"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Tab(
                      icon: Icon(Icons.pending_actions),
                      text: "Completed Duties"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ViewDuties(),
              ViewDutiesWorking(),
              ViewDutiesComplete(),
            ],
          ),
        ),
      ),
    );
  }
}
