import 'package:flutter/material.dart';

class SFSDuties with ChangeNotifier {
  String Id;
  String DutyTitle;
  String ImageUrl;
  String AssignedTo;
  String Category;
  String Location;
  String Priority;
  String TimeDuration;
  String Date;
  String Description;
  String AssignedBy;
  bool isActive;

  SFSDuties({
    this.Id = "D1",
    this.DutyTitle = "CheckPosting",
    this.ImageUrl = "www.pic.com",
    this.AssignedTo = "ASP Awais Shahbaz",
    this.Category = "Checkpost",
    this.Location = "Lahore",
    this.Priority = "High",
    this.TimeDuration = "3-5 Hours",
    this.Date = "29-Nov-2021",
    this.Description = "I am doing Checkposting",
    this.AssignedBy = "SHO",
    this.isActive = false,
  });
  void toggleFavoriteStatus() {
    var old = isActive;

    isActive = !isActive;
    notifyListeners();
  }
}
