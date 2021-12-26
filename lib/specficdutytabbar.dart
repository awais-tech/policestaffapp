import 'package:flutter/material.dart';
import 'package:policesfs/PDuties.dart';
import 'package:policesfs/PDutiesComplete.dart';
import 'package:policesfs/PDutiesWorking.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/ViewDutiesComplete.dart';
import 'package:policesfs/ViewDutiesRequest.dart';
import 'package:policesfs/ViewDutiesWorking.dart';

class specficduty extends StatelessWidget {
  static final routeName = 'specficduty';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: DefaultTabController(
        length: 3,
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
                  child: Tab(
                      icon: Icon(Icons.done_all), text: "Completed\nDuties"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PDuties(id),
              PDutiesWorking(id),
              PDutiesComplete(id),
            ],
          ),
        ),
      ),
    );
  }
}
