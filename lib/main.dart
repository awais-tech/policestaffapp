import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:policestaffapp/Policetabbar.dart';
import 'package:policestaffapp/ViewDetailsOfDuties.dart';

import 'package:policestaffapp/ViewDuties.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: PoliceDutiesStatus(),
      routes: {
        dutydetails.routename: (ctx) => dutydetails(),
        ViewDuties.routeName: (ctx) => ViewDuties(),
        PoliceDutiesStatus.routeName: (ctx) => PoliceDutiesStatus(),
        // Complainantdashboard.routeName: (ctx) => Complainantdashboard(),
        // ComplaintHistory.routeName: (ctx) => ComplaintHistory(),
        // ComplaintTrack.routeName: (ctx) => ComplaintTrack(),
        // Chat.routeName: (ctx) => Chat(),
        // Addcomplaint.routeName: (ctx) => Addcomplaint(),
        // ComplaintEmergency.routeName: (ctx) => ComplaintEmergency(),
        // AboutUs.routeName: (ctx) => AboutUs(),
      },
    );
  }
}
