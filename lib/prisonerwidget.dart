import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:policesfs/ViewPrisoner.dart';
import 'package:select_form_field/select_form_field.dart';
import 'AddJailRecord.dart';
import 'package:intl/intl.dart';

class ViewPrisonerRecord extends StatefulWidget {
  final comp;
  static final routeName = 'ViewPrisonerRecord';

  ViewPrisonerRecord(this.comp);

  @override
  _ViewPrisonerRecordState createState() => _ViewPrisonerRecordState();
}

class _ViewPrisonerRecordState extends State<ViewPrisonerRecord> {
  var _expanded = false;
  var savedate;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _JailCellsRecord =
      FirebaseFirestore.instance.collection("CellRecord");
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
                'PrisonerCNIC: ${widget.comp.data()['PrisonerCNIC']}',
                softWrap: true,
              ),
            ),
            trailing: Container(
              width: 180,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.track_changes),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return editstatus(
                                context, widget.comp.data(), widget.comp.id);
                          });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () async {
                      await _firestore
                          .collection("JailRecord")
                          .doc(widget.comp.id)
                          .delete();
                      await _JailCellsRecord.doc(
                              widget.comp.data()["Prisonerdoc"])
                          .get()
                          .then((val) async {
                        await _JailCellsRecord.doc(
                                widget.comp.data()["Prisonerdoc"])
                            .update({
                          "left": double.parse((val.data() as Map)["left"]) + 1
                        });
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.details_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return editEmail(
                                context, widget.comp.data(), widget.comp.id);
                          });
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
                      'Crime Type:${widget.comp.data()['CrimeType']}',
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
                      'Contact No:${widget.comp.data()["ContactNo"]}',
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

Widget editEmail(BuildContext context, data, id) {
  return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Original Status :In Jail"),
                Text("Current status :${data['status']}"),
                data['update'] == "true"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Current Status Date ${DateFormat('dd/MM/yyyy hh:mm').format(data['updatestatusdate'].toDate())}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    : Container(),
                data['updates'] == "true"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Record Updated on ${DateFormat('dd/MM/yyyy hh:mm').format(data['updateddate'].toDate())}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Prisoner started penalty Date${DateFormat('dd/MM/yyyy hh:mm').format(data['Date added'].toDate())}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('CrimeType:' + (data['CrimeType']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Address:' + (data['Address']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Record Id:' + (data['Record Id']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Number of Days in Jail:' + (data['Days']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Prison No:' + (data['PrisonNo']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Description:' + (data['Description']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Name:' + (data['Name']),
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(data['ImageUrl']),
                      height: 100,
                      width: double.infinity,
                    ),
                  ),
                ),
              ])));
}

Widget editstatus(BuildContext context, data, id) {
  final List<Map<String, dynamic>> status = [
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
      'value': 'Death in Jail',
      'label': 'Death in Jail',
    },
    {
      'value': 'Shift to other Cell',
      'label': 'Shift to other Cell',
    },
  ];
  var statuschan = TextEditingController();
  var years = TextEditingController();
  var changecrime = TextEditingController();
  var savedate;
  final CollectionReference _JailCellsRecord =
      FirebaseFirestore.instance.collection("CellRecord");
  final List<Map<String, dynamic>> CrimeType = [
    {
      'value': 'Theif',
      'label': 'Theif',
    },
    {
      'value': 'Kidnapping',
      'label': 'Kidnapping',
    },
    {
      'value': 'Terroist',
      'label': 'Terroist',
    },
    {
      'value': 'Street Crime',
      'label': 'Street Crime',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    initialValue: data["Days"].toString(),
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Change no of Days',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      years.text = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Days.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: SelectFormField(
                    labelText: 'Change Crime Type',
                    type: SelectFormFieldType.dropdown,
                    initialValue: data["CrimeType"], // or can be dialog
                    items: CrimeType,
                    onChanged: (value) => changecrime.text = value,
                  ),
                ),
                Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
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
                                    initialValue:
                                        data["status"], // or can be dialog
                                    items: status,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                                  vertical: 25,
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          MediaQuery.of(context)
                                                              .padding
                                                              .top) *
                                              0.35),
                                      backgroundColor:
                                          MaterialStateProperty.all(Color(
                                              0xff8d43d6)), // <-- Button color
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>((states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Color(
                                              0xffB788E5); // <-- Splash color
                                      }),
                                    ),
                                    child: const Text(
                                      "Change",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (statuschan.text != "") {
                                        await _firestore
                                            .collection("JailRecord")
                                            .doc(id)
                                            .update({
                                          "status": statuschan.text == ""
                                              ? data["status"]
                                              : statuschan.text,
                                          "updatestatusdate": DateTime.now(),
                                          "Days": years.text == ""
                                              ? data["Days"]
                                              : years.text,
                                          "CrimeType": changecrime.text == ""
                                              ? data["CrimeType"]
                                              : changecrime.text,
                                          "update": "true"
                                        });
                                        if (statuschan.text == "In Jail") {
                                          await _JailCellsRecord.doc(
                                                  data["Prisonerdoc"])
                                              .get()
                                              .then((val) async {
                                            await _JailCellsRecord.doc(
                                                    data["Prisonerdoc"])
                                                .update({
                                              "left": (double.parse((val.data()
                                                          as Map)["left"]) +
                                                      1)
                                                  .toString()
                                            });
                                          });
                                        } else {
                                          await _JailCellsRecord.doc(
                                                  data["Prisonerdoc"])
                                              .get()
                                              .then((val) async {
                                            await _JailCellsRecord.doc(
                                                    data["Prisonerdoc"])
                                                .update({
                                              "left": (double.parse((val.data()
                                                          as Map)["left"]) -
                                                      1)
                                                  .toString(),
                                            });
                                          });
                                        }
                                      } else {
                                        await _firestore
                                            .collection("JailRecord")
                                            .doc(id)
                                            .update({
                                          "status": statuschan.text == ""
                                              ? data["status"]
                                              : statuschan.text,
                                          "updateddate": DateTime.now(),
                                          "Days": years.text == ""
                                              ? data["Days"]
                                              : years.text,
                                          "CrimeType": changecrime.text == ""
                                              ? data["CrimeType"]
                                              : changecrime.text,
                                          "updates": "true"
                                        });
                                      }
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
                                  ))
                            ])))
              ])));
}
          // Padding(
          //     padding: const EdgeInsets.only(bottom: 8.0),
          //     child: ElevatedButton(
          //       style: ButtonStyle(
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         )),
          //         padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          //                 vertical: 25,
          //                 horizontal: MediaQuery.of(context).size.width -
          //                     MediaQuery.of(context).padding.top) *
          //             0.35),
          //         backgroundColor: MaterialStateProperty.all(
          //             Color(0xff8d43d6)), // <-- Button color
          //         overlayColor:
          //             MaterialStateProperty.resolveWith<Color?>((states) {
          //           if (states.contains(MaterialState.pressed))
          //             return Color(0xffB788E5); // <-- Splash color
          //         }),
          //       ),
          //       child: FittedBox(
          //         child: const Text(
          //           "Mark as Done",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).pushNamed(Feedbacks.routename,
          //             arguments: {"status": "Complete", "id": id});
          //       },
          //     )),
          // Padding(
          //     padding: const EdgeInsets.only(bottom: 8.0),
          //     child: ElevatedButton(
          //       style: ButtonStyle(
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         )),
          //         padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          //                 vertical: 25,
          //                 horizontal: MediaQuery.of(context).size.width -
          //                     MediaQuery.of(context).padding.top) *
          //             0.35),
          //         backgroundColor: MaterialStateProperty.all(
          //             Color(0xff8d43d6)), // <-- Button color
          //         overlayColor:
          //             MaterialStateProperty.resolveWith<Color?>((states) {
          //           if (states.contains(MaterialState.pressed))
          //             return Color(0xffB788E5); // <-- Splash color
          //         }),
          //       ),
          //       child: FittedBox(
          //         child: const Text(
          //           "ReAssign Again",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       onPressed: () async {
          //         Navigator.of(context).pushNamed(Feedbacks.routename,
          //             arguments: {"status": "Working", "id": id});
          // await FirebaseFirestore.instance
          //     .collection("Duties")
          //     .doc(id)
          //     .update({
          //   "status": "Working",
          //   "Updation":
          //       "Report is not correct as duty assign Please attach the correct report again"
          // });
          // await FirebaseFirestore.instance
          //     .collection("DutyReport")
          //     .doc(id)
          //     .delete();
          // Navigator.of(context)
          //     .pushNamed(PoliceDutiesStatus.routeName);
          // return await showDialog(
          //   context: context,
          //   builder: (ctx) => AlertDialog(
          //     title: Text('Update'),
          //     content: Text("Status Update"),
          //     actions: <Widget>[
          //       TextButton(
          //         child: Text('Ok'),
          //         onPressed: () {
          //           Navigator.of(ctx).pop(false);
          //         },
          //       ),
          //     ],
          //   ),
          // );
   
