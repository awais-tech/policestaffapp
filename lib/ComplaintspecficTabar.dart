import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/Pcomplete.dart';
import 'package:policesfs/Pworking.dart';
import 'package:policesfs/RequestComplaint.dart';
import 'package:policesfs/ViewComplaintComplete.dart';
import 'package:policesfs/ViewComplaints.dart';
import 'package:policesfs/ViewComplaintsWorking.dart';
import 'package:policesfs/ViewComplaintsassigned.dart';
import 'package:policesfs/ViewDuties.dart';
import 'package:policesfs/ViewDutiesComplete.dart';
import 'package:policesfs/ViewDutiesWorking.dart';

class SpecficTababar extends StatelessWidget {
  static final routeName = 'SpecficPolice';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
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
                  'Check Assigned Complaint',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
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
              Pworking(id),
              Pcomplete(id),
            ],
          ),
        ),
      ),
    );
  }
}
