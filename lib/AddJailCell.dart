import 'package:flutter/material.dart';
import 'package:policesfs/ComplaintsDatabase.dart';
import 'package:policesfs/JailRecords.dart';

class AddJailCellRecord extends StatefulWidget {
  static final routename = "AddJailCellRecord";
  @override
  _AddJailCellRecordState createState() => _AddJailCellRecordState();
}

class _AddJailCellRecordState extends State<AddJailCellRecord> {
  var loading = false;

  var save;
  void AssignDuties(ids) async {
    var form = _form.currentState!.validate();
    if (!form) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      loading = true;
    });
    try {
      await DutiesDatabase.addJailCellRecord(savedata);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Record Added',
                ),
                title: Text(
                  'Perfect',
                  style: TextStyle(color: Colors.green),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(ctx).pushNamed(JailRecords.routeName);
                    },
                  ),
                ],
              ));
    } catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Something Goes wrong ?',
                ),
                title: Text(
                  'Warning',
                  style: TextStyle(color: Colors.red),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ));
    }

    setState(() {
      loading = false;
    });
  }

  final savedata = {
    "PrisonNo": "",
    "TotalCapacity": "",
    "Date": DateTime.now(),
  };

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Jail Cell'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !loading
            ? SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Allocate Prison Cell Number',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Prison Cell Number.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["PrisonerNo"] = value!;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Total Capacity',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Prisoners Capacity.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            savedata["TotalCapacity"] = value!;
                          },
                        ),
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                                vertical: 1,
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        MediaQuery.of(context)
                                                            .padding
                                                            .top) *
                                            0.3),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.red[900])),
                                onPressed: () {
                                  AssignDuties(ids);
                                },
                                child:
                                    FittedBox(child: Text("Add Prison Cell")))),
                      )
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
