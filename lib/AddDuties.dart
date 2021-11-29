import 'package:flutter/material.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:provider/provider.dart';

class AddDutiesScreen extends StatefulWidget {
  @override
  _AddDutiesScreenState createState() => _AddDutiesScreenState();
}

class _AddDutiesScreenState extends State<AddDutiesScreen> {
  final _form = GlobalKey<FormState>();
  SFSDuties PoliceSFSDuties = SFSDuties();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Duty'),
        backgroundColor: Color(0xffB788E5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Duty Title'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  PoliceSFSDuties.DutyTitle = value as String;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned To'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Assigned To.';
                  }
                  return null;
                },
                onSaved: (value) {
                  PoliceSFSDuties.AssignedTo = value as String;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Category.';
                  }
                  return null;
                },
                onSaved: (value) {
                  PoliceSFSDuties.Category = value as String;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned By'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Assigner Name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  PoliceSFSDuties.AssignedBy = value as String;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  PoliceSFSDuties.Description = value as String;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Address'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Location Address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  PoliceSFSDuties.Location = value as String;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Priority'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  PoliceSFSDuties.Priority = value as String;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Date'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onSaved: (value) {
                        PoliceSFSDuties.Date = value as String;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
