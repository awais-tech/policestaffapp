import 'package:flutter/material.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AddDutiesScreen extends StatefulWidget {
  @override
  _AddDutiesScreenState createState() => _AddDutiesScreenState();
}

class _AddDutiesScreenState extends State<AddDutiesScreen> {
  final List<Map<String, dynamic>> _priorities = [
    {
      'value': 'lowValue',
      'label': 'Low',
    },
    {
      'value': 'mediumValue',
      'label': 'Medium',
    },
    {
      'value': 'highValue',
      'label': 'High',
    },
  ];
  final List<Map<String, dynamic>> _Categories = [
    {
      'value': 'checkpostValue',
      'label': 'Checkposting',
    },
    {
      'value': 'raidValue',
      'label': 'Raid',
    },
    {
      'value': 'theftValue',
      'label': 'Theft Investigation',
    },
    {
      'value': 'robberyValue',
      'label': 'Robbery Investigation',
    },
    {
      'value': 'assualtValue',
      'label': 'Assualt Investigation',
    },
    {
      'value': 'childAbuseValue',
      'label': 'Child Abuse Investigation',
    },
    {
      'value': 'domesticAbuseValue',
      'label': 'Domestic Abuse Investigation',
    },
    {
      'value': 'kidnapValue',
      'label': 'Kidnapping Investigation',
    },
    {
      'value': 'drugsValue',
      'label': 'Alcohol & Drugs Investigation',
    },
  ];
  final _form = GlobalKey<FormState>();
  SFSDuties PoliceSFSDuties = SFSDuties();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Duties'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.always,
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
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Assign To',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Assigned To.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    PoliceSFSDuties.AssignedTo = value as String;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: SelectFormField(
                  labelText: 'Select Category',
                  type: SelectFormFieldType.dropdown,
                  initialValue: 'theft', // or can be dialog
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
                      return 'Please enter a Category.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    PoliceSFSDuties.Category = value as String;
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
                    onSaved: (val) => PoliceSFSDuties.Date = val as String,
                  )),
              Center(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                        vertical: 1,
                                        horizontal:
                                            MediaQuery.of(context).size.width -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
                                    0.3),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[900])),
                        onPressed: () {},
                        child: Text("Assign"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
