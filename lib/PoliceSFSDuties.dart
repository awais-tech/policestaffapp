import 'package:flutter/material.dart';

class SFSDuties with ChangeNotifier {
  final String Id;
  final String DutyTitle;
  final String ImageUrl;
  final String AssignedTo;
  final String Category;
  final String Location;
  final String Priority;
  final String TimeDuration;
  final String Date;
  final String Description;
  final String AssignedBy;
  bool isActive;

  SFSDuties({
    required this.Id,
    required this.DutyTitle,
    required this.ImageUrl,
    required this.AssignedTo,
    required this.Category,
    required this.Location,
    required this.Priority,
    required this.TimeDuration,
    required this.Date,
    required this.Description,
    required this.AssignedBy,
    this.isActive = false,
  });
  void toggleFavoriteStatus() {
    var old = isActive;

    isActive = !isActive;
    notifyListeners();
  }
}
