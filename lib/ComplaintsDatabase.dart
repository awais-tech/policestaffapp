import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/PoliceSFSDuties.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("Duties");
final CollectionReference _maincomplaints = _firestore.collection("Complaints");
final CollectionReference _mainDuty = _firestore.collection("DutyReport");
final CollectionReference _mainCrime = _firestore.collection("CriminalRecord");

class DutiesDatabase {
  static String? userID;

  static Future<void> UpdateDuties(ids, Complaints) async {
    DocumentReference collectionRef = _maincomplaints.doc(ids);

    Random random = new Random();
    int randomNumber = random.nextInt(100) + 2;
    String no = DateTime.now().microsecond.toString() + randomNumber.toString();
    _firestore
        .collection('PoliceStaff')
        .doc(Complaints["PoliceOfficer"])
        .get()
        .then((val) async {
          final url = Uri.parse(
              'https://fitnessappauth.herokuapp.com/api/users/TokenRefreshs');
          Map<String, String> headers = {"Content-type": "application/json"};

          var doc = await http.post(
            url,
            headers: headers,
            body: json.encode({
              'email': (val.data() as Map)["Email"],
              'message':
                  "Hi ${(val.data() as Map)["Name"]}!<br> You assigned  a Complaint to Resolve  <h1>Desscription from SHO</h1> ${Complaints["Description"]}<br> <h1>Desscription from Complainer</h1>:${Complaints["Description"]} <br> For accept duties and see further detail please open the app",
            }),
          );
          await collectionRef
              .update({
                "status": "assigned",
                "PoliceOfficerid": Complaints["PoliceOfficer"],
                "OfficerName": (val.data() as Map)["Name"],
                "DescriptionForOfficer": Complaints["Description"],
                "Priority": Complaints["Priority"],
                "Date Assigned": Complaints["Date"],
                "ComplaintNo": no,
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
      var Name =
          json.decode(Constants.prefs.getString('userinfo') as String)['Name'];
      _firestore
          .collection('PoliceStaff')
          .doc(policeStation.AssignedTo)
          .get()
          .then((val) async {
        final url = Uri.parse(
            'https://fitnessappauth.herokuapp.com/api/users/TokenRefreshs');
        Map<String, String> headers = {"Content-type": "application/json"};

        var doc = await http.post(
          url,
          headers: headers,
          body: json.encode({
            'email': (val.data() as Map)["Email"],
            'message':
                "Hi ${(val.data() as Map)["Name"]}!<br> You assigned  a duty at ${policeStation.Location}<br> <h1>Desscription</h1>:${policeStation.Description} <br> For accept duties and see further detail please open the app",
          }),
        );
        await _mainCollection.add({
          "Location": policeStation.Location,
          "Assign by": Name,
          "PoliceStaffid": policeStation.AssignedTo,
          "Title": policeStation.DutyTitle,
          "Category": policeStation.Category,
          "Description": policeStation.Description,
          "Priority": policeStation.Priority,
          "Date Created": policeStation.Date,
          "Policestationid": json.decode(
              Constants.prefs.getString('userinfo') as String)['StationId'],
          "status": "Pending"
        });
      });
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  static Future<void> addCrimRecord(Complaints, image) async {
    try {
      Random random = new Random();
      int randomNumber = random.nextInt(1000) + 100;
      int randoms = random.nextInt(10);
      String no = randoms.toString() +
          DateTime.now().microsecond.toString() +
          randomNumber.toString();
      print(Complaints["Title"]);
      await _mainCrime.add({
        "status": Complaints["Status"],
        "PoliceOfficerid": FirebaseAuth.instance.currentUser!.uid,
        "Person Name": Complaints["Name"],
        "Description": Complaints["Description"],
        "Title": Complaints["Title"],
        "ImageUrl": image,
        "Record Id": no,
        "Date added": Complaints["Date"],
        "CrimeType": Complaints["CrimeType"],
        "IdentificationMark": Complaints["IdentificationMark"],
        "Policestationid": json.decode(
            Constants.prefs.getString('userinfo') as String)['StationId'],
      });
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  static Future<void> UploadRepord(Complaints, image, id) async {
    try {
      DocumentReference collectionRef = _mainDuty.doc(id);
      DocumentReference collections = _mainCollection.doc(id);
      collectionRef.set({
        "Description": Complaints["Description"],
        "Image": image,
        "Date": Complaints["Date"],
      });
      collections.update({
        "status": "Request",
      });
    } catch (e) {
      throw e;
    }
  }
}
