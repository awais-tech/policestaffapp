import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:policesfs/Constants.dart';
import 'package:select_form_field/select_form_field.dart';

class EmergencyView extends StatefulWidget {
  final comp;

  EmergencyView(this.comp);

  @override
  _EmergencyViewState createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('PoliceStation')
        .doc(widget.comp.data()["Policestationid"])
        .snapshots();

    return StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          return Card(
            elevation: 10,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Record ID: ${widget.comp.data()['Record Id']}',
                    softWrap: true,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    'Crime Reason: ${widget.comp.data()['CrimeType']}',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                    textAlign: TextAlign.start,
                  ),
                  trailing: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        json.decode(Constants.prefs.getString('userinfo')
                                    as String)['Role'] ==
                                "Operator"
                            ? TextButton(
                                child: Text("Change Status"),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return changestatus(
                                            context,
                                            "Change Status",
                                            widget.comp,
                                            snapshot.data!);
                                      });
                                },
                              )
                            : Container(),
                        IconButton(
                          icon: Icon(Icons.info_outline_rounded),
                          color: Colors.red[900],
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return editEmail(context, "View Detail",
                                      widget.comp, snapshot.data!);
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Widget editEmail(BuildContext context, String title, compl, station) {
  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Detail'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                DateFormat('dd/MM/yyyy hh:mm')
                    .format(compl.data()['Date added'].toDate()),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Person Name:' + (compl.data()['Person Name']),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Identification Mark:' + (compl.data()['IdentificationMark']),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Status:' + compl.data()['status'],
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Police Station Name:' + station.data()['Division'],
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(compl.data()['ImageUrl']),
                height: 100,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget changestatus(BuildContext context, String title, compl, station) {
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
      'value': 'Complete its punishment',
      'label': 'Complete its punishment',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
  ];
  var statuschan = TextEditingController();
  statuschan.text = compl.data()["status"];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Change Status'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: SelectFormField(
                onChanged: (val) => statuschan.text = val,
                labelText: 'Change Status',
                type: SelectFormFieldType.dropdown,
                initialValue: compl.data()["status"], // or can be dialog
                items: status,
              ),
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
                      Colors.red[900]), // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xffB788E5); // <-- Splash color
                  }),
                ),
                child: const Text(
                  "Change",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(statuschan.text);
                  print(compl.id);
                  await _firestore
                      .collection("CriminalRecord")
                      .doc(compl.id)
                      .update({"status": statuschan.text});
                  return await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Update'),
                      content: Text("Status Update"),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    ),
  );
}
