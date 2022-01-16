import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/Bottommodaltitle.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/Straightline.dart';
import 'package:policesfs/inputborder.dart';
import 'package:provider/provider.dart';

// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';

class Profile extends StatefulWidget {
  static const routeName = 'Profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final myList = [
    'CNIC',
    'Phoneno',
    'Password',
    'Address',
    'Name',
    'Role',
    'Division',
    'Email'
  ];

  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  void submit(value, name) async {
    try {
      final dat =
          await json.decode(Constants.prefs.getString('userinfo') as String);
      if (name == "CNIC") {
        FirebaseFirestore.instance
            .collection("PoliceStaff")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({name: value});

        final userinfo = json.encode({
          'Name': dat['Name'],
          'Division': dat['Division'],
          'Role': dat['Role'],
          'StationId': dat['StationId'],
          'Email': dat['Email'],
          'Address': dat['Address'],
          'Phoneno': dat['Phoneno'],
          'CNIC': value,
          "Password": dat["Password"]
        });
        await Constants.prefs.setString('userinfo', userinfo);
      }

      if (name == "Address") {
        FirebaseFirestore.instance
            .collection("PoliceStaff")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({name: value});

        final userinfo = json.encode({
          'Name': dat['Name'],
          'Division': dat['Division'],
          'Role': dat['Role'],
          'StationId': dat['StationId'],
          'Email': dat['Email'],
          'Address': value,
          'Phoneno': dat['Phoneno'],
          'CNIC': dat['CNIC'],
          "Password": dat["Password"]
        });
        await Constants.prefs.setString('userinfo', userinfo);
      }
      if (name == "PhoneNo") {
        FirebaseFirestore.instance
            .collection("PoliceStaff")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({name: value});

        final userinfo = json.encode({
          'Name': dat['Name'],
          'Division': dat['Division'],
          'Role': dat['Role'],
          'StationId': dat['StationId'],
          'Email': dat['Email'],
          'Address': dat['Address'],
          'Phoneno': value,
          'CNIC': dat["CNIC"],
          "Password": dat["Password"]
        });
        await Constants.prefs.setString('userinfo', userinfo);
      }
      if (name == "Password") {
        final c = FirebaseAuth.instance.currentUser;
        final cre = EmailAuthProvider.credential(
            email: dat["Email"], password: dat["Password"]);
        c!.reauthenticateWithCredential(cre).then((va) {
          c
              .updatePassword(value as String)
              .then((valu) => print("change"))
              .catchError((error) {
            _showErrorDialogue("Something Goes Wrong");
          });
        }).catchError((error) {
          _showErrorDialogue("Something Goes Wrong");
        });

        final userinfo = json.encode({
          'Name': dat['Name'],
          'Division': dat['Division'],
          'Role': dat['Role'],
          'StationId': dat['StationId'],
          'Email': dat['Email'],
          'Address': dat['Address'],
          'Phoneno': dat['Phoneno'],
          'CNIC': dat["CNIC"],
          "Password": value
        });
        await Constants.prefs.setString('userinfo', userinfo);
      }
    } on FirebaseAuthException catch (error) {
      _showErrorDialogue(error.message!);
    } catch (e) {
      _showErrorDialogue("Something Goes Wrong");
      throw (e);
    }
    Navigator.of(context).pop();
    setState(() {});
  }

  void _showErrorDialogue(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay')),
        ],
      ),
    );
  }
  // Widget progessButton() {
  //   return Container();
  //   // return ProgressButton.icon(iconedButtons: {
  //   //   ButtonState.idle: IconedButton(
  //   //       text: "Save Changes",
  //   //       icon: Icon(Icons.save_alt_rounded, color: Colors.white),
  //   //       color: Colors.pink.shade900),
  //   //   ButtonState.loading:
  //   //       IconedButton(text: "Loading", color: Colors.pink.shade900),
  //   //   ButtonState.fail: IconedButton(
  //   //       text: "Failed",
  //   //       icon: Icon(Icons.cancel, color: Colors.white),
  //   //       color: Colors.red.shade300),
  //   //   ButtonState.success: IconedButton(
  //   //       text: "Success",
  //   //       icon: Icon(
  //   //         Icons.check_circle,
  //   //         color: Colors.white,
  //   //       ),
  //   //       color: Colors.green.shade400)
  //   // }, onPressed: () {});
  // }

  Widget editCNIC(BuildContext context, String title) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bottommodeltitle(title),
          Divider(
            thickness: 2,
          ),
          Container(
            decoration: putborder(),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.person_add_alt,
                    color: Color(0xff8d43d6),
                  ),
                ),
                Straightline(),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Edit  CNIC',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.top) *
                    0.35),
                backgroundColor: MaterialStateProperty.all(
                    Color(0xff8d43d6)), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Color(0xffB788E5); // <-- Splash color
                }),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => {
                submit(
                  name.text,
                  "CNIC",
                )
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget editEmail(BuildContext context, String title) {
  //   return Padding(
  //     padding: MediaQuery.of(context).viewInsets,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Bottommodeltitle(title),
  //         Divider(
  //           thickness: 2,
  //         ),
  //         Container(
  //           decoration: putborder(),
  //           margin:
  //               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  //           child: Row(
  //             children: <Widget>[
  //               new Padding(
  //                 padding:
  //                     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
  //                 child: Icon(
  //                   Icons.email_outlined,
  //                   color: Color(0xff8d43d6),
  //                 ),
  //               ),
  //               Straightline(),
  //               Expanded(
  //                 child: TextField(
  //                   keyboardType: TextInputType.streetAddress,
  //                   controller: email,
  //                   decoration: InputDecoration(
  //                     labelText: 'Edit address',
  //                     border: InputBorder.none,
  //                     hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 8.0),
  //           child: ElevatedButton(
  //             style: ButtonStyle(
  //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                   RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               )),
  //               padding: MaterialStateProperty.all(EdgeInsets.symmetric(
  //                       vertical: 25,
  //                       horizontal: MediaQuery.of(context).size.width -
  //                           MediaQuery.of(context).padding.top) *
  //                   0.35),
  //               backgroundColor: MaterialStateProperty.all(
  //                   Color(0xff8d43d6)), // <-- Button color
  //               overlayColor:
  //                   MaterialStateProperty.resolveWith<Color?>((states) {
  //                 if (states.contains(MaterialState.pressed))
  //                   return Color(0xffB788E5); // <-- Splash color
  //               }),
  //             ),
  //             child: const Text(
  //               "submit",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             onPressed: () => {
  //               submit(
  //                 email.text,
  //                 "address",
  //               )
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget editAddress(BuildContext context, String title) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bottommodeltitle(title),
          Divider(
            thickness: 2,
          ),
          Container(
            decoration: putborder(),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.add_call,
                    color: Color(0xff8d43d6),
                  ),
                ),
                Straightline(),
                Expanded(
                  child: TextField(
                    controller: phone,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Edit Address',
                      border: InputBorder.none,
                      hintText: 'Please enter Your address',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.top) *
                    0.35),
                backgroundColor: MaterialStateProperty.all(
                    Color(0xff8d43d6)), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Color(0xffB788E5); // <-- Splash color
                }),
              ),
              child: const Text(
                "submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => {
                submit(
                  phone.text,
                  "Address",
                )
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget editPhone(BuildContext context, String title) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bottommodeltitle(title),
          Divider(
            thickness: 2,
          ),
          Container(
            decoration: putborder(),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.add_call,
                    color: Color(0xff8d43d6),
                  ),
                ),
                Straightline(),
                Expanded(
                  child: TextField(
                    controller: phone,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Edit Phone Number',
                      border: InputBorder.none,
                      hintText: 'Please enter phone with area code',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.top) *
                    0.35),
                backgroundColor: MaterialStateProperty.all(
                    Color(0xff8d43d6)), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Color(0xffB788E5); // <-- Splash color
                }),
              ),
              child: const Text(
                "submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => {
                submit(
                  phone.text,
                  "PhoneNo",
                )
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget editPassword(BuildContext context, String title) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bottommodeltitle(title),
          Divider(
            thickness: 2,
          ),
          Container(
            decoration: putborder(),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.map_outlined,
                    color: Color(0xff8d43d6),
                  ),
                ),
                Straightline(),
                Expanded(
                  child: TextField(
                    controller: password,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter New Password',
                      border: InputBorder.none,
                      hintText: 'Please atleast 8 characters',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    obscureText: true,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.top) *
                    0.35),
                backgroundColor: MaterialStateProperty.all(
                    Color(0xff8d43d6)), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Color(0xffB788E5); // <-- Splash color
                }),
              ),
              child: const Text(
                "submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => {
                if (password.text.length < 8)
                  {
                    Navigator.of(context).pop(),
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Password must be 8 character long',
                      ),
                      duration: Duration(seconds: 2),
                    )),
                  }
                else
                  {
                    submit(
                      password.text,
                      "Password",
                    )
                  }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myListData = [
      json.decode(Constants.prefs.getString('userinfo') as String)['CNIC'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Phoneno'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Password'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Address'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Name'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Role'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Division'],
      json.decode(Constants.prefs.getString('userinfo') as String)['Email'],
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              elevation: 5,
              child: ListTile(
                onTap: () {},
                title: Text(
                  "${myList[index]}",
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(
                  "${myListData[index]}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                trailing: index < 4
                    ? IconButton(
                        icon: Icon(Icons.edit),
                        color: Color(0xff8d43d6),
                        onPressed: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                if (index == 0)
                                  return editCNIC(context, "Edit CNIC");
                                // else if (index == 1)
                                //   return editEmail(context, "Edit Email");
                                else if (index == 1)
                                  return editPhone(context, "Edit Phone");
                                else if (index == 2)
                                  return editPassword(
                                      context, "Change Password");
                                else
                                  return editAddress(context, "Change Address");
                              });
                        },
                      )
                    : Icon(Icons.view_compact),
              ),
            );
          }),
    );
  }
}
