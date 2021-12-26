import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AddJailRecord.dart';

class ViewJailCellsRecord extends StatefulWidget {
  final comp;
  static final routeName = 'ViewJailCellsRecord';

  ViewJailCellsRecord(this.comp);

  @override
  _ViewJailCellsRecordState createState() => _ViewJailCellsRecordState();
}

class _ViewJailCellsRecordState extends State<ViewJailCellsRecord> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('CellRecords')
        .doc(widget.comp.data()["PrisonNo"])
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
                  leading: FittedBox(
                    child: Text(
                      'Allocated Prison Cell ID: ${widget.comp.data()['PrisonNo']}',
                      softWrap: true,
                    ),
                  ),
                  trailing: Container(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddJailRecord.routename);
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Total Capacity:${widget.comp.data()['PrisonNo']}',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Space Left:00',
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
