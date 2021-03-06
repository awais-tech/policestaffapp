import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/AddJailCell.dart';
import 'package:policesfs/Constants.dart';
import 'ViewJailCells.dart';
import 'dart:convert';

class JailRecords extends StatefulWidget {
  static final routeName = 'JailRecord';

  @override
  State<JailRecords> createState() => _JailRecordsState();
}

class _JailRecordsState extends State<JailRecords> {
  final stream =
      FirebaseFirestore.instance.collection('CellRecord').snapshots();
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FittedBox(child: Text('Jail Record')),
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
                      labelText: 'Search by Prison ID',
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
                                    ? (snp.data!.docs[i].data()
                                                as Map)["PrisonerNo"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                name.toString().toLowerCase())
                                        ? ViewJailCellsRecord(snp.data!.docs[i])
                                        : Container()
                                    : ViewJailCellsRecord(snp.data!.docs[i])));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: json.decode(Constants.prefs.getString('userinfo')
                      as String)['Role'] ==
                  "Operator" ||
              json.decode(Constants.prefs.getString('userinfo') as String)[
                      'Role'] ==
                  "Police Inspector"
          ? FloatingActionButton(
              child: Icon(
                Icons.add_circle_outline_sharp,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AddJailCellRecord.routename);
              },
              backgroundColor: Colors.red[900],
            )
          : null,
    );
  }
}
