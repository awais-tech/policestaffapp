import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:policestaffapp/PoliceSFSDuties.dart';

class PoliceSfsDutiesProvider with ChangeNotifier {
  // List<SFSDuties> SfsDuties = [
  //   SFSDuties(
  //       Id: "A1",
  //       DutyTitle: "Shadiwal Chowk Checkposting",
  //       ImageUrl: "www.org.com",
  //       AssignedTo: "ASP Awais Shahbaz",
  //       Category: "Checkposting",
  //       Location: "Shadiwal Chowk Johar town LHR",
  //       Priority: "Normal",
  //       TimeDuration: "4 Hours",
  //       Date: Date.now(),
  //       Description:
  //           "Manage the Checkpost on that area and check the every suspected vehicles",
  //       AssignedBy: "SHO Daniyal Ayyaz")
  // ];
  // List<SFSDuties> get duties {
  //   return [...SfsDuties];
  // }

  // List<SFSDuties> get dutyStatus {
  //   return SfsDuties.where((dutyStatus) => dutyStatus.isActive).toList();
  // }

  // SFSDuties findById(String id) {
  //   return duties.firstWhere((duty) => duty.Id == id);
  // }

  // List<SFSDuties> findByPoliceOfficer(String name) {
  //   return duties.where((duty) => duty.AssignedTo.contains(name)).toList();
  // }

  // List<SFSDuties> findAssigner(id) {
  //   return duties.where((duty) => duty.AssignedBy == id).toList();
  // }
}
