import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddJailCell.dart';
import 'package:policesfs/Constants.dart';
import 'package:policesfs/ViewJailCells.dart';
import 'package:policesfs/prisonerwidget.dart';
import 'dart:convert';
import 'AddJailRecord.dart';

class ViewPrisoner extends StatefulWidget {
  static final routeName = 'ViewPrisoner';

  @override
  _ViewPrisonerState createState() => _ViewPrisonerState();
}

class _ViewPrisonerState extends State<ViewPrisoner> {
  var _expanded = false;
  var name = "";
  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)?.settings.arguments;
    final stream = FirebaseFirestore.instance
        .collection('JailRecord')
        .where("Prisonerdoc", isEqualTo: ids)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FittedBox(child: Text('Prisoner Record')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              SizedBox(
                width: 10,
              ), //
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (val) => setState(() {
                      name = val;
                    }),
                    decoration: InputDecoration(
                      fillColor: Colors.blueAccent[50],
                      filled: true,
                      labelText: 'Search by Name',
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
                                  ? (snp.data!.docs[i].data() as Map)["Name"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              name.toString().toLowerCase())
                                      ? ViewPrisonerRecord(snp.data!.docs[i])
                                      : Container()
                                  : ViewPrisonerRecord(snp.data!.docs[i]),
                            ),
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
