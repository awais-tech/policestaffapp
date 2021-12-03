import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("Duties");
final CollectionReference _maincomplaints = _firestore.collection("Complaints");

class DutiesDatabase {
  static String? userID;

  static Future<void> UpdateDuties(ids, Complaints) async {
    DocumentReference collectionRef = _maincomplaints.doc(ids);
    _firestore
        .collection('PoliceStaff')
        .doc(Complaints["PoliceOfficer"])
        .get()
        .then((val) async {
          await collectionRef
              .update({
                "status": "assigned",
                "PoliceOfficerid": Complaints["PoliceOfficer"],
                "OfficerName": (val.data() as Map)["Name"],
                "DescriptionForOfficer": Complaints["Description"],
                "Priority": Complaints["Priority"],
                "Date Assigned": Complaints["Date"],
              })
              .then((value) => print("User Account Status Updated"))
              .catchError(
                  (error) => print("Failed to update transaction: $error"));
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
        "PoliceStaffid": policeStation.AssignedTo,
        "Title": policeStation.DutyTitle,
        "Category": policeStation.Category,
        "Description": policeStation.Description,
        "Priority": policeStation.Priority,
        "Date Created": policeStation.Date,
        "status": "Pending"
      });
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
