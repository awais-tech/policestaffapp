import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddDuties.dart';
import 'package:policesfs/Chat/OperatorChat.dart';
import 'package:policesfs/Chat/chat.dart';
import 'package:policesfs/ChatUser.dart';
import 'package:policesfs/CriminalRecords.dart';
import 'package:policesfs/ComplaintReport.dart';
import 'package:policesfs/ComplaintTabbar.dart';
import 'package:policesfs/ComplaintsFeedback.dart';
import 'package:policesfs/Complaintsapprove.dart';
import 'package:policesfs/Complaintspamcheck.dart';
import 'package:policesfs/ComplaintspecficTabar.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/Dashboard.dart';
import 'package:policesfs/DeatilEmgergency.dart';
import 'package:policesfs/DetailsSPam.dart';
import 'package:policesfs/DutyReport.dart';
import 'package:policesfs/Dutyfeedback.dart';

import 'package:policesfs/JailRecords.dart';
import 'package:policesfs/Login.dart';
import 'package:policesfs/AddJailRecord.dart';
import 'package:policesfs/OperatorDashborad.dart';
import 'package:policesfs/Pcomplete.dart';
import 'package:policesfs/Policetabbar.dart';
import 'package:policesfs/AddCriminalRecord.dart';
import 'package:policesfs/Pworking.dart';
import 'package:policesfs/RequestComplaint.dart';
import 'package:policesfs/Screens/ManageAllEmergency/AllEmergency.dart';
import 'package:policesfs/Screens/ManageAllEmergency/emergencytab.dart';
import 'package:policesfs/Spamchecker.dart';
import 'package:policesfs/Stafflist.dart';
import 'package:policesfs/Userdetail.dart';
import 'package:policesfs/ViewComplaints.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/ViewDetailsofComplaints.dart';
import 'package:policesfs/ViewDutiesRequest.dart';
import 'package:policesfs/ViewPrisoner.dart';
import 'package:policesfs/specficdutytabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddJailCell.dart';
import 'AssignComplaints.dart';
import 'package:policesfs/ViewDuties.dart';
import 'ViewJailRecords.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return MaterialApp(
        home: Scaffold(
          body: AlertDialog(
            content: Text('Something went wrong. Please restart the app.'),
          ),
        ),
      );
    }
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Police SFS',
      theme: ThemeData(
        primaryColor: Color(0xffB788E5),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.data != null) {
              return json.decode(Constants.prefs.getString('userinfo')
                          as String)['Role'] ==
                      ""
                  ? Center(child: CircularProgressIndicator())
                  : json.decode(Constants.prefs.getString('userinfo')
                              as String)['Role'] ==
                          "Operator"
                      ? Operatordashboard()
                      : Staffdashboard();
            }

            return Constants.prefs.getBool('login') == true
                ? json.decode(Constants.prefs.getString('userinfo') as String)[
                            'Role'] ==
                        "Operator"
                    ? Operatordashboard()
                    : Staffdashboard()
                : LoginScreen();
          }),
      routes: {
        Staffdashboard.routeName: (ctx) => Staffdashboard(),
        AddDutiesScreen.routename: (ctx) => AddDutiesScreen(),
        dutydetails.routename: (ctx) => dutydetails(),
        ViewDuties.routeName: (ctx) => ViewDuties(),
        PoliceDutiesStatus.routeName: (ctx) => PoliceDutiesStatus(),
        Complaintdetails.routename: (ctx) => Complaintdetails(),
        AssignComplaintsScreen.routename: (ctx) => AssignComplaintsScreen(),
        ViewComplaints.routeName: (ctx) => ViewComplaints(),
        PolicsComplaintStatus.routeName: (ctx) => PolicsComplaintStatus(),
        JailRecords.routeName: (ctx) => JailRecords(),
        Operatordashboard.routeName: (ctx) => Operatordashboard(),
        OperatorStatus.routeName: (ctx) => OperatorStatus(),
        Complaintspampending.routeName: (ctx) => Complaintspampending(),
        ComplaintsApprove.routeName: (ctx) => ComplaintsApprove(),
        detailsofSpam.routename: (ctx) => detailsofSpam(),
        ComplaintEmergency.routeName: (ctx) => ComplaintEmergency(),
        AddCrimeRecord.routename: (ctx) => AddCrimeRecord(),
        AddJailRecord.routename: (ctx) => AddJailRecord(),
        AddJailCellRecord.routename: (ctx) => AddJailCellRecord(),
        DutyReport.routename: (ctx) => DutyReport(),
        ViewDutiesRequest.routeName: (ctx) => ViewDutiesRequest(),
        Feedbacks.routename: (ctx) => Feedbacks(),
        RequestComplaint.routeName: (ctx) => RequestComplaint(),
        FeedbacksC.routename: (ctx) => FeedbacksC(),
        ComplaintReport.routename: (ctx) => ComplaintReport(),
        UserDetail.routename: (ctx) => UserDetail(),
        StaffList.routeName: (ctx) => StaffList(),
        Pworking.routeName: (ctx) => Pworking(""),
        Pcomplete.routeName: (ctx) => Pcomplete(""),
        SpecficTababar.routeName: (ctx) => SpecficTababar(),
        specficduty.routeName: (ctx) => specficduty(),
        ViewPrisoner.routeName: (ctx) => ViewPrisoner(),
        Chat.routeName: (ctx) => Chat(),
        ChatUser.routeName: (ctx) => ChatUser(),
        OperatorChat.routeName: (ctx) => OperatorChat(),
        OperatorEmergency.routeName: (ctx) => OperatorEmergency(),
        DetailEmergency.routename: (ctx) => DetailEmergency(),
        AllEmergency.routeName: (ctx) => AllEmergency()
      },
    );
  }
}
