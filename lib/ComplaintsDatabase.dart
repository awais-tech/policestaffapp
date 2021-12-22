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
final CollectionReference _maincomplaintsR =
    _firestore.collection("ComplaintsReport");
final CollectionReference _mainDuty = _firestore.collection("DutyReport");
final CollectionReference _mainCrime = _firestore.collection("CriminalRecord");
final CollectionReference _JailsRecord = _firestore.collection("JailRecord");
final CollectionReference _JailCellsRecord =
    _firestore.collection("CellRecord");

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
                "Assigned By": json.decode(
                    Constants.prefs.getString('userinfo') as String)["Name"],
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

  static Future<void> addJailCellRecord(Cell) async {
    try {
      Random random = new Random();
      int randomNumber = random.nextInt(1000) + 100;
      int randoms = random.nextInt(10);
      String no = randoms.toString() +
          DateTime.now().microsecond.toString() +
          randomNumber.toString();
      print(Cell["TotalCapacity"]);
      await _JailCellsRecord.add({
        "PrisonerNo": Cell["PrisonerNo"],
        "TotalCapacity": Cell["TotalCapacity"],
        "Record Id": no,
        "Date added": Cell["Date"],
        "Division": json.decode(
            Constants.prefs.getString('userinfo') as String)['Division'],
        "Policestationid": json.decode(
            Constants.prefs.getString('userinfo') as String)['StationId'],
      });
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  static Future<void> addJailRecord(Complaints, image) async {
    try {
      Random random = new Random();
      int randomNumber = random.nextInt(1000) + 100;
      int randoms = random.nextInt(10);
      String no = randoms.toString() +
          DateTime.now().microsecond.toString() +
          randomNumber.toString();
      print(Complaints["TotalPrisoners"]);
      await _JailsRecord.add({
        "ContactNo": Complaints["ContactNo"],
        "PoliceOfficerid": FirebaseAuth.instance.currentUser!.uid,
        "PrisonNo": Complaints["PrisonNo"],
        "Address": Complaints["Address"],
        "Description": Complaints["Description"],
        "PrisonerCNIC": Complaints["PrisonerCNIC"],
        "ImageUrl": image,
        "Record Id": no,
        "Date added": Complaints["Date"],
        "CrimeType": Complaints["CrimeType"],
        "Policestationid": json.decode(
            Constants.prefs.getString('userinfo') as String)['StationId'],
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
        "status": "Remarks Needed",
        "Date": Complaints["Date"],
      });
      collections.update({
        "status": "Request",
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> RequestComplaints(Complaints, image, id) async {
    try {
      DocumentReference _maincomplain = _maincomplaints.doc(id);
      DocumentReference _maincomplai = _maincomplaintsR.doc(id);
      _maincomplai.set({
        "Description": Complaints["Description"],
        "Image": image,
        "status": "Remarks Needed",
        "Date": Complaints["Date"],
      });
      _maincomplain.update({
        "status": "Request",
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> UploadFeedback(Complaints, id) async {
    try {
      DocumentReference collectionRef = _mainDuty.doc(id["id"]);
      DocumentReference collections = _mainCollection.doc(id["id"]);
      collectionRef.update({
        "SHOFeedback": Complaints["Description"],
        "status": id["status"],
      });
      collections.update({
        "status": id["status"],
        "SHOFeedback": Complaints["Description"],
      });
      _firestore.collection('Duties').doc(id["id"]).get().then((va) async {
        _firestore
            .collection('PoliceStaff')
            .doc(va.data()!["PoliceStaffid"])
            .get()
            .then((val) async {
          if (id["status"] == "Working") {
            final url = Uri.parse(
                'https://fitnessappauth.herokuapp.com/api/users/TokenRefreshs');
            Map<String, String> headers = {"Content-type": "application/json"};

            var doc = await http.post(
              url,
              headers: headers,
              body: json.encode({
                'email': (val.data() as Map)["Email"],
                'message':
                    "Hi ${(val.data() as Map)["Name"]}!<br> You duty about ${va.data()!["Title"]} has been ReAssign to you <br>Please check  SHO remarks ${Complaints["Description"]}<br>",
              }),
            );
          } else {
            final url = Uri.parse(
                'https://fitnessappauth.herokuapp.com/api/users/TokenRefreshs');
            Map<String, String> headers = {"Content-type": "application/json"};

            var doc = await http.post(
              url,
              headers: headers,
              body: json.encode({
                'email': (val.data() as Map)["Email"],
                'message':
                    "Hi ${(val.data() as Map)["Name"]}!<br> You duty about ${va.data()!["Title"]} has been Completed  <br>Please check  SHO remarks ${Complaints["Description"]}<br>",
              }),
            );
          }
        });
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> UploadFeedbacks(Complaints, id) async {
    try {
      DocumentReference collectionRef = _maincomplaints.doc(id["id"]);
      DocumentReference collections = _maincomplaintsR.doc(id["id"]);
      collectionRef.update({
        "SHOFeedback": Complaints["Description"],
        "status": id["status"],
        "Ufeedback": ""
      });
      collections.update({
        "status": id["status"],
        "SHOFeedback": Complaints["Description"],
      });
      _firestore.collection('Complaints').doc(id["id"]).get().then((va) async {
        _firestore
            .collection('PoliceStaff')
            .doc(va.data()!["PoliceOfficerid"])
            .get()
            .then((val) async {
          if (id["status"] == "Working") {
            final url = Uri.parse(
                'https://fitnessappauth.herokuapp.com/api/users/TokenRefreshs');
            Map<String, String> headers = {"Content-type": "application/json"};

            var doc = await http.post(
              url,
              headers: headers,
              body: json.encode({
                'email': (val.data() as Map)["Email"],
                'message':
                    "Hi ${(val.data() as Map)["Name"]}!<br> You Complaint about ${va.data()!["Title"]} has been ReAssign to you <br>Please check  SHO remarks ${Complaints["Description"]}<br>",
              }),
            );
          } else {
            final url = Uri.parse(
                'https://fitnessappauth.herokuapp.com/api/users/TokenRefreshs');
            Map<String, String> headers = {"Content-type": "application/json"};

            var doc = await http.post(
              url,
              headers: headers,
              body: json.encode({
                'email': (val.data() as Map)["Email"],
                'message':
                    "Hi ${(val.data() as Map)["Name"]}!<br> You Complaint about ${va.data()!["Title"]} has been Completed  <br>Please check  SHO remarks ${Complaints["Description"]}<br>",
              }),
            );
          }
        });
      });
    } catch (e) {
      throw e;
    }
  }
}
