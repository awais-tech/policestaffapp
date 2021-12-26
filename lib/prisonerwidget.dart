import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/ViewPrisoner.dart';
import 'AddJailRecord.dart';

class ViewPrisonerRecord extends StatefulWidget {
  final comp;
  static final routeName = 'ViewPrisonerRecord';

  ViewPrisonerRecord(this.comp);

  @override
  _ViewPrisonerRecordState createState() => _ViewPrisonerRecordState();
}

class _ViewPrisonerRecordState extends State<ViewPrisonerRecord> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: FittedBox(
              child: Text(
                'Allocated Prison Cell ID: ${widget.comp.data()['PrisonerNo']}',
                softWrap: true,
              ),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      var id = widget.comp.data()['PrisonerNo'];
                      var ids = widget.comp.id;
                      Navigator.of(context)
                          .pushNamed(AddJailRecord.routename, arguments: {
                        "ids": id,
                        "idd": ids,
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Total Capacity:${widget.comp.data()['TotalCapacity']}',
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
                      'Capacity Left:${widget.comp.data()["left"]}',
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
  }
}
