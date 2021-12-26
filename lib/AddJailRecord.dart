import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policesfs/ComplaintsDatabase.dart';
import 'package:policesfs/JailRecords.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:policesfs/camera.dart';
import 'package:policesfs/image_upload.dart';

class AddJailRecord extends StatefulWidget {
  static final routename = "AddJailRecord";
  @override
  _AddJailRecordState createState() => _AddJailRecordState();
}

class _AddJailRecordState extends State<AddJailRecord> {
  var loading = false;

  bool _isInit = true;
  var save;
  void AssignDuties(id) async {
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
      await DutiesDatabase.addJailRecord(savedata, "as", id["ids"], id["idd"]);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Record Added',
                ),
                title: Text(
                  'Perfect',
                  style: TextStyle(color: Colors.red),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(ctx).pushNamed(JailRecords.routeName);
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
    "Description": "",
    "PrisonNo": "",
    "Address": '',
    "Name": '',
    "PrisonerCNIC": "",
    "ImageUrl": "",
    "ContactNo": "",
    "DateTime": DateTime.now(),
  };
  final List<Map<String, dynamic>> status = [
    {
      'value': 'Empty',
      'label': 'Empty',
    },
    {
      'value': 'Have Prisoners',
      'label': 'Have Prisoners',
    },
    {
      'value': 'Full',
      'label': 'Full',
    },
    {
      'value': 'Other',
      'label': 'Other',
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
      'value': 'Street Crime',
      'label': 'Street Crime',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
  ];
  XFile? _userImageFile;
  void _pickedImage(XFile image) {
    _userImageFile = image;
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Prisoners'),
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
                            labelText: 'Prisoner CNIC/B-Form Number',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Title.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["PrisonerCNIC"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Contact Number',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Title.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["ContactNo"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Contact Number',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Priosoner Name.';
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
                        child: SelectFormField(
                          labelText: 'Select Crime Type',
                          type: SelectFormFieldType.dropdown,
                          initialValue: 'Street Crime', // or can be dialog
                          items: CrimeType,
                          onSaved: (value) {
                            savedata["CrimeType"] = value!;
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
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Prisoner Residential Address',
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
                            savedata["Address"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Prisoner Description',
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
                      // Container(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: TextFormField(
                      //     maxLines: 4,
                      //     decoration: InputDecoration(
                      //       labelText: 'Identification Mark',
                      //       border: OutlineInputBorder(),
                      //     ),
                      //     textInputAction: TextInputAction.next,
                      //     keyboardType: TextInputType.text,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please enter Identification Mark.';
                      //       }
                      //       return null;
                      //     },
                      //     onSaved: (value) {
                      //       savedata["IdentificationMark"] = value!;
                      //     },
                      //   ),
                      // ),
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
                                child: Text("Add Prisoner"))),
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
