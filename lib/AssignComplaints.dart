import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policestaffapp/ComplaintTabbar.dart';
import 'package:policestaffapp/ComplaintsDatabase.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AssignComplaintsScreen extends StatefulWidget {
  static final routename = "assignComplaints";
  @override
  _AssignComplaintsScreenState createState() => _AssignComplaintsScreenState();
}

class _AssignComplaintsScreenState extends State<AssignComplaintsScreen> {
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
      await DutiesDatabase.UpdateDuties(ids, savedata);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Complaints has been assigned ?',
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

  final savedata = {
    'PoliceOfficer': "",
    'Priority': '',
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
        title: Text('Assign Complaints'),
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
                      child: SelectFormField(
                        labelText: 'Select Police Officer',
                        type: SelectFormFieldType.dropdown,
                        initialValue: 'Select',
                        items: save,
                        onChanged: (val) => print(val),
                        onSaved: (value) {
                          savedata["PoliceOfficer"] = value as String;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: SelectFormField(
                        labelText: 'Select Complaint Priority',
                        type: SelectFormFieldType.dropdown,
                        initialValue: 'low', // or can be dialog
                        items: _Priority,
                        onChanged: (val) => print(val),
                        onSaved: (value) {
                          savedata["Priority"] = value!;
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
