import 'dart:convert';
import 'dart:io';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Dashboard.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  var token;

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _userId;

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(message),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    try {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      final userin = json.encode({
        'Role': "",
      });
      await prefs.setString('userinfo', userin);
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: _authData["email"] as String,
        password: _authData["password"] as String,
      );
      _userId = authResult.user!.uid;

      CollectionReference staff = _firestore.collection('PoliceStaff');
      var dat = await staff.doc(_userId!).get();
      final userinfo = json.encode({
        'Name': dat['Name'],
        'Division': dat['PoliceStationDivision'],
        'Role': dat['Role'],
        'StationId': dat['PoliceStationID'],
        'Email': dat['Email'],
        'Address': dat['Address'],
        'Phoneno': dat['PhoneNo'],
        'CNIC': dat['CNIC'],
        "Password": _authData["password"]
      });

      await prefs.setString('userinfo', userinfo);
      await prefs.setString('userData', authResult.user!.uid);
      await prefs.setBool('login', true);
      await _auth.signOut();
      await _auth.signInWithEmailAndPassword(
        email: _authData["email"] as String,
        password: _authData["password"] as String,
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';

      _showErrorDialog(errorMessage);
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: double.infinity,
                          child: Card(
                            shadowColor: Colors.blueGrey,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                )),
                            margin: EdgeInsets.all(20),
                            elevation: 30,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: ClipPath(
                                            clipper: WaveClipperOne(
                                                flip: true, reverse: false),
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue[900],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.0))),
                                              child: Center(
                                                child: Text(
                                                  "WELCOME TO POLICE SFS",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                MediaQuery.of(
                                                                        context)
                                                                    .padding
                                                                    .top) *
                                                            0.060,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 15.0),
                                                child: Icon(
                                                  Icons.person_outline,
                                                  color: Colors.red[900],
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                                width: 1.0,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                margin: const EdgeInsets.only(
                                                    left: 00.0, right: 10.0),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your Email Address',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty ||
                                                        !value.contains('@')) {
                                                      return 'Invalid email!';
                                                    }
                                                  },
                                                  onSaved: (value) {
                                                    _authData['email'] = value!;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 15.0),
                                                child: Icon(
                                                  Icons.lock_open,
                                                  color: Colors.red[900],
                                                ),
                                              ),
                                              Container(
                                                height: 10.0,
                                                width: 1.0,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                margin: const EdgeInsets.only(
                                                    left: 00.0, right: 10.0),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Password',
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your Password here',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty ||
                                                        value.length < 6) {
                                                      return 'Password is too short!';
                                                    }
                                                  },
                                                  onSaved: (value) {
                                                    _authData['password'] =
                                                        value!;
                                                  },
                                                  obscureText: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 35),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    )),
                                                    padding: MaterialStateProperty
                                                        .all(EdgeInsets.symmetric(
                                                                vertical: 1,
                                                                horizontal: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .padding
                                                                        .top) *
                                                            0.08),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red[
                                                                900]), // <-- Button color
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith<
                                                                    Color?>(
                                                                (states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed))
                                                        return Colors.red[
                                                            800]; // <-- Splash color
                                                    }),
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0),
                                                          child: Text(
                                                            "Login",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                        ),
                                                        Transform.translate(
                                                          offset:
                                                              Offset(15.0, 0.0),
                                                          child: Container(
                                                            // padding: const EdgeInsets.on(1.0),
                                                            child: TextButton(
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed: () =>
                                                                  {_submit()},
                                                              // Navigator.of(context)
                                                              //     .pushReplacementNamed(
                                                              //   HomeScreen.route,
                                                              // )
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed: () => {_submit()},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
