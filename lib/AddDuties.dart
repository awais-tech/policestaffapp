import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policestaffapp/ComplaintsDatabase.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddDutiesScreen extends StatefulWidget {
  static final routename = "addduties";

  @override
  _AddDutiesScreenState createState() => _AddDutiesScreenState();
}

class _AddDutiesScreenState extends State<AddDutiesScreen> {
  bool loading = false;
  bool _isInit = true;
  var save;

  void didChangeDependencies() {
    print(2);
    if (_isInit) {
      setState(() {
        loading = true;
      });
      final result = FirebaseFirestore.instance
          .collection('PoliceStaff')
          .get()
          .then((result) {
        save = result.docs
            .map((val) => {
                  'label': val.data()["Name"],
                  "value": val.data()["PoliceStaffId"]
                })
            .toList();
        setState(() {
          loading = false;
        });
      });

      _isInit = false;

      super.didChangeDependencies();
    }
  }

  void AssignDuties() async {
    var form = _form.currentState!.validate();
    if (!form) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      loading = true;
    });
    try {
      await DutiesDatabase.addDuties(PoliceSFSDuties);
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

  final List<Map<String, dynamic>> _priorities = [
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
  final List<Map<String, dynamic>> _Categories = [
    {
      'value': 'checkpost',
      'label': 'Checkposting',
    },
    {
      'value': 'raid',
      'label': 'Raid',
    },
    {
      'value': 'theft',
      'label': 'Theft Investigation',
    },
    {
      'value': 'robbery',
      'label': 'Robbery Investigation',
    },
    {
      'value': 'assualt',
      'label': 'Assualt Investigation',
    },
    {
      'value': 'childAbuse',
      'label': 'Child Abuse Investigation',
    },
    {
      'value': 'domesticAbuse',
      'label': 'Domestic Abuse Investigation',
    },
    {
      'value': 'kidnap',
      'label': 'Kidnapping Investigation',
    },
    {
      'value': 'drugs',
      'label': 'Alcohol & Drugs Investigation',
    },
  ];
  final _form = GlobalKey<FormState>();
  SFSDuties PoliceSFSDuties = SFSDuties(Date: DateTime.now());

  @override
  Widget build(BuildContext context) {
    print(save);
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Duties'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !loading
            ? Form(
                key: _form,
                child: ListView(
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
                            return 'Please enter a Title.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          PoliceSFSDuties.DutyTitle = value as String;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: SelectFormField(
                        labelText: 'Assigned To',
                        type: SelectFormFieldType.dropdown,
                        initialValue: 'Select',
                        items: save,
                        onChanged: (val) => print(val),
                        onSaved: (value) {
                          PoliceSFSDuties.AssignedTo = value as String;
                        },
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(15.0),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Assign To',
                    //     ),
                    //     textInputAction: TextInputAction.next,
                    //     keyboardType: TextInputType.text,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please enter a Assigned To.';
                    //       }
                    //       return null;
                    //     },
                    //     onSaved: (value) {
                    //       PoliceSFSDuties.AssignedTo = value as String;
                    //     },
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: SelectFormField(
                        labelText: 'Select Category',
                        type: SelectFormFieldType.dropdown,
                        initialValue: 'theft',
                        items: _Categories,
                        onChanged: (val) => print(val),
                        onSaved: (value) {
                          PoliceSFSDuties.Category = value as String;
                        },
                      ),
                    ),
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
                          PoliceSFSDuties.Description = value as String;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Location Address',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Location Address.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          PoliceSFSDuties.Location = value as String;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: SelectFormField(
                        labelText: 'Select Priority',
                        type: SelectFormFieldType.dropdown,
                        initialValue: 'low', // or can be dialog
                        items: _priorities,
                        onChanged: (val) => print(val),
                        onSaved: (value) {
                          PoliceSFSDuties.Priority = value as String;
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
                          onSaved: (val) => PoliceSFSDuties.Date =
                              DateTime.parse(val as String),
                        )),
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
                                AssignDuties();
                              },
                              child: Text("Assign"))),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
