import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policesfs/ComplaintEmergency.dart';
import 'package:policesfs/ComplaintTabbar.dart';
import 'package:policesfs/ComplaintsDatabase.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/PoliceSFSDuties.dart';
import 'package:policesfs/PoliceSFSDutiesProvider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:policesfs/camera.dart';
import 'package:policesfs/image_upload.dart';

class AddCrimeRecord extends StatefulWidget {
  static final routename = "AddCrimeRecord";
  @override
  _AddCrimeRecordState createState() => _AddCrimeRecordState();
}

class _AddCrimeRecordState extends State<AddCrimeRecord> {
  var loading = false;

  bool _isInit = true;
  var save;
  void AssignDuties(ids) async {
    var form = _form.currentState!.validate();
    if (!form) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      loading = true;
    });
    try {
      final ref = FirebaseStorage.instance.ref().child(_userImageFile!.name);

      await ref.putFile(File(_userImageFile!.path));
      final download = await ref.getDownloadURL();
      await DutiesDatabase.addCrimRecord(savedata, download);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Record Added',
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
                      Navigator.of(ctx).pushNamed(ComplaintEmergency.routeName);
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

  final savedata = {
    'CrimeType': '',
    'Status': '',
    "Description": "",
    "Name": "",
    "Title": "",
    "ImageUrl": "",
    "IdentificationMark": "",
    "Date": DateTime.now(),
  };
  final List<Map<String, dynamic>> status = [
    {
      'value': 'Missing',
      'label': 'Missing',
    },
    {
      'value': 'in Jail',
      'label': 'in Jail',
    },
    {
      'value': 'Ran away from Jail',
      'label': 'Ran away from Jail',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
    {
      'value': 'Complete its punishment',
      'label': 'Complete its punishment',
    },
  ];
  final List<Map<String, dynamic>> CrimeType = [
    {
      'value': 'Theif',
      'label': 'Theif',
    },
    {
      'value': 'Kidnapping',
      'label': 'Kidnapping',
    },
    {
      'value': 'Terroist',
      'label': 'Terroist',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
    {
      'value': 'Street Crime',
      'label': 'Street Crime',
    },
  ];
  XFile? _userImageFile;
  void _pickedImage(XFile image) {
    _userImageFile = image;
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Criminal Record'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !loading
            ? SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Title.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["Title"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: SelectFormField(
                          labelText: 'Select Crime Type',
                          type: SelectFormFieldType.dropdown,
                          initialValue: 'Kidnapping', // or can be dialog
                          items: CrimeType,
                          onSaved: (value) {
                            savedata["CrimeType"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: SelectFormField(
                          labelText: 'Select Status',
                          type: SelectFormFieldType.dropdown,
                          initialValue: 'in Jail', // or can be dialog
                          items: status,
                          onSaved: (value) {
                            savedata["Status"] = value!;
                          },
                        ),
                      ),

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
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Identification Mark',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Identification Mark.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["IdentificationMark"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name Of Person',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Name of Person.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["Name"] = value!;
                          },
                        ),
                      ),
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
                                savedata["Date"] =
                                    DateTime.parse(val as String);
                              })),
                      UserImagePicker(_pickedImage),
                      camera(_pickedImage),
                      SizedBox(
                        height: 8,
                      ),
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
                                                horizontal:
                                                    MediaQuery.of(context)
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
                                child: Text("Add Criminal Record"))),
                      )
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
