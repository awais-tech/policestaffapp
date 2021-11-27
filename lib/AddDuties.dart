import 'package:flutter/material.dart';
import 'package:policestaffapp/PoliceSFSDuties.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:provider/provider.dart';

class AddDutiesScreen extends StatefulWidget {
  @override
  _AddDutiesScreenState createState() => _AddDutiesScreenState();
}

class _AddDutiesScreenState extends State<AddDutiesScreen> {
  //final _priceFocusNode = FocusNode();
  final _DescriptionFocusNode = FocusNode();
  final _image = FocusNode();
  final _imageUrlController = TextEditingController();
  final _TextControl = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool loading = false;
  bool init = true;
  var _editedDuties = SFSDuties(
    Id: '',
    DutyTitle: '',
    AssignedTo: '',
    Category: '',
    AssignedBy: '',
    ImageUrl: '',
    TimeDuration: '',
    Date: '',
    Description: '',
    Location: '',
    Priority: '',
    isActive: false,
  );
  var initial = {
    'TimeDuration': '',
    'Description': '',
    'AssignedTo': '',
    'Category': '',
    'AssignedBy': '',
    'Date': '',
  };
  @override
  void dispose() {
    //_priceFocusNode.dispose();
    _DescriptionFocusNode.dispose();
    _image.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    _image.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (init) {
    //   final Id = '1';

    //   if (Id != null) {
    //     _editedDuties =
    //         Provider.of<PoliceSfsDutiesProvider>(context, listen: false)
    //             .findById(Id as String);
    //     initial = {
    //       'TimeDuration': _editedDuties.TimeDuration.toString(),
    //       'Description': _editedDuties.Description,
    //       'AssignedTo': _editedDuties.AssignedTo,
    //       'Category': _editedDuties.Category,
    //       'AssignedBy': _editedDuties.AssignedBy,
    //       'Date': _editedDuties.Date.toString(),
    //     };
    //     _imageUrlController.text = _editedDuties.ImageUrl;
    //     _TextControl.text = _editedDuties.DutyTitle;
    //   }
    // }
    // init = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    setState(() {});
  }

  void saveform() async {
    var form = _form.currentState!.validate();
    if (!form) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      loading = true;
    });

    // if (_editedDuties.Id != '') {
    //   try {
    //     await Provider.of<PoliceSfsDutiesProvider>(context, listen: false)
    //         .updateDuties(_editedDuties);
    //   } catch (e) {
    //     print(333);
    //   }
    // } else {
    //   try {
    //     await Provider.of<PoliceSfsDutiesProvider>(context, listen: false)
    //         .addDuties(_editedDuties);
    //   } catch (e) {
    //     await showDialog(
    //         context: context,
    //         builder: (ctx) => AlertDialog(
    //               content: Text(
    //                 'Something Goes wrong ?',
    //               ),
    //               title: Text(
    //                 'Warning',
    //                 style: TextStyle(color: Colors.red),
    //               ),
    //               actions: [
    //                 TextButton(
    //                   child: Text('Ok'),
    //                   onPressed: () {
    //                     Navigator.of(ctx).pop();
    //                   },
    //                 ),
    //               ],
    //             ));
    //   }
    // }
    setState(() {
      loading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Duty'),
        backgroundColor: Color(0xffB788E5),
        actions: [IconButton(onPressed: saveform, icon: Icon(Icons.save))],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.green,
              semanticsLabel: 'Please Wait',
            ))
          : Padding(
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
                      controller: _TextControl,
                      // onFieldSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus(_priceFocusNode);
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least ${10 - _TextControl.text.length.toInt()} characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: value!,
                            AssignedTo: _editedDuties.AssignedTo,
                            Category: _editedDuties.Category,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: _editedDuties.TimeDuration,
                            Date: _editedDuties.Date,
                            Description: _editedDuties.Description,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
                      },
                    ),
                    TextFormField(
                      initialValue: initial['AssignedTo'] as String,
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
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: _editedDuties.DutyTitle,
                            AssignedTo: value!,
                            Category: _editedDuties.Category,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: _editedDuties.TimeDuration,
                            Date: _editedDuties.Date,
                            Description: _editedDuties.Description,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
                      },
                    ),
                    TextFormField(
                      initialValue: initial['Category'] as String,
                      decoration: InputDecoration(labelText: 'Category'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Ctageory.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: _editedDuties.DutyTitle,
                            AssignedTo: _editedDuties.AssignedTo,
                            Category: value!,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: _editedDuties.TimeDuration,
                            Date: _editedDuties.Date,
                            Description: _editedDuties.Description,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
                      },
                    ),
                    TextFormField(
                      initialValue: initial['Dilvery'] as String,
                      decoration: InputDecoration(labelText: 'Dilvery'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a .';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: value!,
                            AssignedTo: _editedDuties.AssignedTo,
                            Category: _editedDuties.Category,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: _editedDuties.TimeDuration,
                            Date: _editedDuties.Date,
                            Description: _editedDuties.Description,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
                      },
                    ),
                    TextFormField(
                      initialValue: initial['duration'] as String,
                      decoration: InputDecoration(labelText: 'duration'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: value!,
                            AssignedTo: _editedDuties.AssignedTo,
                            Category: _editedDuties.Category,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: _editedDuties.TimeDuration,
                            Date: _editedDuties.Date,
                            Description: _editedDuties.Description,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
                      },
                    ),
                    TextFormField(
                      initialValue: initial['price'] as String,
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      //focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_DescriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: _editedDuties.DutyTitle,
                            AssignedTo: _editedDuties.AssignedTo,
                            Category: _editedDuties.Category,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: value!,
                            Date: _editedDuties.Date,
                            Description: _editedDuties.Description,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      initialValue: initial['description'] as String,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _DescriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_image);
                      },
                      onSaved: (value) {
                        _editedDuties = SFSDuties(
                            Id: _editedDuties.Id,
                            DutyTitle: _editedDuties.DutyTitle,
                            AssignedTo: _editedDuties.AssignedTo,
                            Category: _editedDuties.Category,
                            AssignedBy: _editedDuties.AssignedBy,
                            ImageUrl: _editedDuties.ImageUrl,
                            TimeDuration: _editedDuties.TimeDuration,
                            Date: _editedDuties.Date,
                            Description: value!,
                            Location: _editedDuties.Location,
                            Priority: _editedDuties.Priority,
                            isActive: _editedDuties.isActive);
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
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _image,
                            onFieldSubmitted: (_) => {saveform},
                            onSaved: (value) {
                              _editedDuties = SFSDuties(
                                  Id: _editedDuties.Id,
                                  DutyTitle: _editedDuties.DutyTitle,
                                  AssignedTo: _editedDuties.AssignedTo,
                                  Category: _editedDuties.Category,
                                  AssignedBy: _editedDuties.AssignedBy,
                                  ImageUrl: value!,
                                  TimeDuration: _editedDuties.TimeDuration,
                                  Date: _editedDuties.Date,
                                  Description: _editedDuties.Description,
                                  Location: _editedDuties.Location,
                                  Priority: _editedDuties.Priority,
                                  isActive: _editedDuties.isActive);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                      !value.startsWith('https') ||
                                  value.contains('www')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
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
