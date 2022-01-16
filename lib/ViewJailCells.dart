import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/ViewPrisoner.dart';
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
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: FittedBox(
              child: Text(
                'Allocated Prison Cell ID: ${widget.comp.data()['PrisonerNo']}',
                softWrap: true,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  widget.comp.data()['left'] == "0"
                      ? IconButton(
                          color: Colors.red[900],
                          tooltip: "Capacity is Full",
                          icon: Icon(Icons.add),
                          onPressed: null,
                        )
                      : IconButton(
                          color: Colors.red[900],
                          icon: Icon(Icons.add),
                          onPressed: () {
                            var id = widget.comp.data()['PrisonerNo'];
                            var capacity = widget.comp.data()['left'];
                            var ids = widget.comp.id;
                            Navigator.of(context)
                                .pushNamed(AddJailRecord.routename, arguments: {
                              "ids": id,
                              "idd": ids,
                              "capacity": capacity,
                            });
                          },
                        ),
                  IconButton(
                    icon: Icon(Icons.list_rounded),
                    color: Colors.red[900],
                    onPressed: () {
                      var ids = widget.comp.id;
                      Navigator.of(context)
                          .pushNamed(ViewPrisoner.routeName, arguments: ids);
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Total Capacity: ${widget.comp.data()['TotalCapacity']}',
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Capacity Left: ${widget.comp.data()["left"]}',
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
  }
}
