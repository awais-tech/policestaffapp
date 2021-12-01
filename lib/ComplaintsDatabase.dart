import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("Duties");

class DutiesDatabase {
  static String? userID;

  static Future<void> UpdateDuties(policeStation) async {
    DocumentReference collectionRef = _mainCollection.doc();
    await collectionRef
        .update({
          "Address": policeStation.Address,
          "Division": policeStation.Division,
          "Name": policeStation.Name,
          "Nearst Location": policeStation.NearstLocation,
          "No of cells": policeStation.NoofCells,
          "Postel Code": policeStation.PostelCode,
          "Station Phone No": policeStation.StationPhoneno,
          "imageUrl": policeStation.imageUrl
        })
        .then((value) => print("User Account Status Updated"))
        .catchError((error) => print("Failed to update transaction: $error"));
  }

  static Future<void> DutiesDelete({
    required String mainid,
  }) async {
    DocumentReference collectionRef = _mainCollection.doc(mainid);

    await collectionRef.delete();

    print("User Account Deleted");
  }

  static Future<void> addDuties(SFSDuties policeStation) async {
    try {
      await _mainCollection.add({
        "Location": policeStation.Location,
        "Assign by": policeStation.AssignedBy,
        "PoliceStaffName": policeStation.AssignedTo,
        "Title": policeStation.DutyTitle,
        "Category": policeStation.Category,
        "Description": policeStation.Description,
        "Priority": policeStation.Priority,
        "Date Created": policeStation.Date,
        "status": "pending"
      });
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
