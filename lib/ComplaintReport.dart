import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policesfs/ComplaintTabbar.dart';
import 'package:policesfs/ComplaintsDatabase.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/PoliceSFSDuties.dart';
import 'package:policesfs/PoliceSFSDutiesProvider.dart';
import 'package:policesfs/Policetabbar.dart';
import 'package:policesfs/ViewDetailsOfDuties.dart';
import 'package:policesfs/ViewDutiesRequest.dart';
import 'package:policesfs/camera.dart';
import 'package:policesfs/image_upload.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class ComplaintReport extends StatefulWidget {
  static final routename = "ComplaintReport";
  @override
  _ComplaintReportState createState() => _ComplaintReportState();
}

class _ComplaintReportState extends State<ComplaintReport> {
  var loading = false;

  bool _isInit = true;
  var save;
  void AssignDuties(ids) async {
    var id = ModalRoute.of(context)?.settings.arguments;
    var form = _form.currentState!.validate();
    if (!form) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      loading = true;
    });
    try {
      // final ref = FirebaseStorage.instance.ref().child(_userImageFile!.name);

      // await ref.putFile(File(_userImageFile!.path));
      // final download = await ref.getDownloadURL();
      await DutiesDatabase.RequestComplaints(savedata, "download", id);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Request sent',
                ),
                title: Text(
                  'Alert',
                  style: TextStyle(color: Colors.red),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(ctx)
                          .pushNamed(PolicsComplaintStatus.routeName);
                    },
                  ),
                ],
              ));
    } catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Something Goes wrong ?',
                ),
                title: Text(
                  'Warning',
                  style: TextStyle(color: Colors.red),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ));
    }

    setState(() {
      loading = false;
    });
  }

  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       loading = true;
  //     });
  //     var stationId = json
  //         .decode(Constants.prefs.getString('userinfo') as String)['StationId'];
  //     final result = FirebaseFirestore.instance
  //         .collection('PoliceStaff')
  //         .where("PoliceStationID", isEqualTo: stationId)
  //         .where("Role", whereNotIn: ['Police Inspector', 'Operator'])
  //         .get()
  //         .then((result) {
  //           save = result.docs
  //               .map((val) => {
  //                     'label': val.data()["Name"],
  //                     "value": val.data()["PoliceStaffId"]
  //                   })
  //               .toList();
  //           setState(() {
  //             loading = false;
  //           });
  //         });

  //     _isInit = false;

  //     super.didChangeDependencies();
  //   }
  // }

  XFile? _userImageFile;
  void _pickedImage(XFile image) {
    _userImageFile = image;
  }

  final savedata = {
    "Description": "",
    "Date": DateTime.now(),
  };
  final List<Map<String, dynamic>> _Priority = [
    {
      'value': 'low',
      'label': 'Low',
    },
    {
      'value': 'medium',
      'label': 'Medium',
    },
    {
      'value': 'high',
      'label': 'High',
    },
  ];
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Report'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !loading
            ? Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    // Visibility(
                    //   child: TextFormField(
                    //     maxLines: 4,
                    //     decoration: InputDecoration(
                    //       labelText: 'Hidden Field',
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //   ),
                    //   maintainSize: false,
                    //   maintainAnimation: true,
                    //   maintainState: true,
                    //   visible: false,
                    // ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Description.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          savedata["Description"] = value!;
                        },
                      ),
                    ),
                    // UserImagePicker(_pickedImage),
                    // camera(_pickedImage),
                    Container(
                        padding: const EdgeInsets.all(15.0),
                        child: DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Time",
                            selectableDayPredicate: (date) {
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }
                              return true;
                            },
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {
                              savedata["Date"] = DateTime.parse(val as String);
                            })),

                    Center(
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                              vertical: 1,
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top) *
                                          0.3),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[900])),
                              onPressed: () {
                                AssignDuties(ids);
                              },
                              child:
                                  Text("Send for Review for closed the case"))),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
