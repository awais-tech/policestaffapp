import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddJailCell.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/ViewJailCells.dart';
import 'package:policesfs/prisonerwidget.dart';
import 'package:select_form_field/select_form_field.dart';
import 'dart:convert';
import 'AddJailRecord.dart';

class ViewPrisoner extends StatefulWidget {
  static final routeName = 'ViewPrisoner';

  @override
  _ViewPrisonerState createState() => _ViewPrisonerState();
}

class _ViewPrisonerState extends State<ViewPrisoner> {
  var _expanded = false;
  var search = "Name";
  var name = "";
  var status = 'All';
  final List<Map<String, dynamic>> Allstatus = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'In Jail',
      'label': 'In Jail',
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
    {
      'value': 'No punishment Release',
      'label': 'No punishment Release',
    },
    {
      'value': 'Shift to other Cell',
      'label': 'Shift to other Cell',
    },
  ];

  final List<Map<String, dynamic>> searching = [
    {
      'value': 'Name',
      'label': 'Name',
    },
    {
      'value': 'PrisonerCNIC',
      'label': 'PrisonerCNIC',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)?.settings.arguments;

    var stream;
    print(status);
    if (status != "All") {
      stream = FirebaseFirestore.instance
          .collection('JailRecord')
          .where("Prisonerdoc", isEqualTo: ids)
          .where("status", isEqualTo: status)
          .snapshots();
    } else {
      stream = FirebaseFirestore.instance
          .collection('JailRecord')
          .where("Prisonerdoc", isEqualTo: ids)
          .snapshots();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FittedBox(child: Text('Prisoner Record')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              margin: EdgeInsets.all(15),
              padding: const EdgeInsets.all(3.0),
              child: SelectFormField(
                onChanged: (val) => setState(() {
                  status = val;
                }),
                labelText: 'Filter By Status',
                type: SelectFormFieldType.dropdown,
                initialValue: "All", // or can be dialog
                items: Allstatus,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              margin: EdgeInsets.all(15),
              padding: const EdgeInsets.all(3.0),
              child: SelectFormField(
                onChanged: (val) => setState(() {
                  search = val;
                }),
                labelText: 'Search by',
                type: SelectFormFieldType.dropdown,
                initialValue: "Name", // or can be dialog
                items: searching,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Icon(Icons.search),
              ),
              SizedBox(
                width: 10,
              ), //
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20, right: 15),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (val) => setState(() {
                      name = val;
                    }),
                    decoration: InputDecoration(
                      fillColor: Colors.blueAccent[50],
                      filled: true,
                      labelText: 'Search by ${search}',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      labelStyle:
                          TextStyle(fontSize: 16.0, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snp) {
                  if (snp.hasError) {
                    print(snp);
                    return Center(
                      child: Text("No Data is here"),
                    );
                  } else if (snp.hasData || snp.data != null) {
                    return snp.data!.docs.length < 1
                        ? Center(child: Container(child: Text("No Record")))
                        : ListView.builder(
                            itemCount: snp.data!.docs.length,
                            itemBuilder: (ctx, i) => Container(
                                child: name != ""
                                    ? (snp.data!.docs[i].data() as Map)[search]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                name.toString().toLowerCase())
                                        ? ViewPrisonerRecord(snp.data!.docs[i])
                                        : Container()
                                    : ViewPrisonerRecord(snp.data!.docs[i])),
                          );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
