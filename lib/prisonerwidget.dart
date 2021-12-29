import 'package:cloud_firestore/cloud_firestore.dart';
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
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.track_changes),
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
  final List<Map<String, dynamic>> status = [
    {
      'value': 'On Bail',
      'label': 'On Bail',
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
    {
      'value': 'No punishment Release',
      'label': 'No punishment Release',
    },
  ];
  var statuschan = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Report'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      DateFormat('dd/MM/yyyy hh:mm')
                          .format(data['Date added'].toDate()),
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
                                    initialValue: "in Jail", // or can be dialog
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
                                      await _firestore
                                          .collection("JailRecord")
                                          .doc(id)
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
   
