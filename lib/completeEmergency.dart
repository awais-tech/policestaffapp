import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                              'Crime Reason :${widget.comp.data()['CrimeType']}',
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
