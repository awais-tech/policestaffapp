import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:policesfs/Constants.dart';
import 'package:select_form_field/select_form_field.dart';

class ComplEmergency extends StatefulWidget {
  final comp;

  ComplEmergency(this.comp);

  @override
  _ComplEmergencyState createState() => _ComplEmergencyState();
}

class _ComplEmergencyState extends State<ComplEmergency> {
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
            elevation: 6,
            margin: EdgeInsets.all(6),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        ' ${widget.comp.data()['Title']} ',
                        softWrap: true,
                      ),
                    ),
                  ),
                  subtitle: FittedBox(
                    child: Text(
                      'Record Id: ${widget.comp.data()['Record Id']}',
                      softWrap: true,
                    ),
                  ),
                  trailing: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.details_outlined),
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
                          icon: Icon(_expanded
                              ? Icons.expand_less
                              : Icons.expand_more),
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (_expanded)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 70,
                          child: Text(
                            'Description: ${widget.comp.data()['Description']}',
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'CrimeReason :${widget.comp.data()['CrimeType']}',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
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
      'value': 'Other',
      'label': 'Other',
    },
    {
      'value': 'Complete its punishment',
      'label': 'Complete its punishment',
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
          Text('Change status'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: SelectFormField(
                onChanged: (val) => statuschan.text = val,
                labelText: 'Change status',
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
                      Color(0xff8d43d6)), // <-- Button color
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
