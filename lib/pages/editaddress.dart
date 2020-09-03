import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  static const routename = '/editaddress';

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  bool edit = false;
  bool _isLoading = false;
  final _formkey = GlobalKey<FormState>();
  String userId;
  String addressId;
  var address1 = '';
  var address2 = '';
  var landmark = '';
  var postalcode = 0;
  var contactno = 0;
  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState.save();
      _submitFn();
    }
  }

  void _submitFn() async {
    setState(() {
      _isLoading = true;
    });

    if (!edit) {
      await Firestore.instance
          .collection('users/' + userId + '/saved addresses')
          .document()
          .setData(
        {
          'line1': address1,
          'line2': address2,
          'postalcode': postalcode,
          'landmark': landmark,
          'contactno': contactno
        },
      );
    } else if (edit) {
      await Firestore.instance
          .collection('users/' + userId + '/saved addresses')
          .document(addressId)
          .updateData(
        {
          'line1': address1,
          'line2': address2,
          'postalcode': postalcode,
          'landmark': landmark,
          'contactno': contactno
        },
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var addressData;
    var args = ModalRoute.of(context).settings.arguments as List;
    userId = args[0];

    if (args.length > 1) {
      setState(() {
        edit = true;
      });
      addressId = args[1];
      addressData = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(edit ? 'Edit Address' : 'Add Address'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _trySubmit,
          )
        ],
      ),
      body: Center(
        child: Container(
          child: _isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (value) {
                              address1 = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                            initialValue: edit ? addressData['line1'] : null,
                            decoration: InputDecoration(
                              labelText: 'Address Line 1',
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              address2 = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                            initialValue: edit ? addressData['line2'] : null,
                            decoration: InputDecoration(
                              labelText: 'Address Line 2',
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              landmark = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                            initialValue: edit ? addressData['landmark'] : null,
                            decoration: InputDecoration(
                              labelText: 'Landmark',
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              postalcode = int.parse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 6 ||
                                  !(int.tryParse(value) is int)) {
                                return 'Please enter at least 6 numbers';
                              }
                              return null;
                            },
                            initialValue:
                                edit ? addressData['postalcode'] : null,
                            decoration: InputDecoration(
                              labelText: 'Postal Code',
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              contactno = int.parse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 10 ||
                                  !(int.tryParse(value) is int)) {
                                return 'Please enter a valid mobile number';
                              }
                              return null;
                            },
                            initialValue:
                                edit ? addressData['contactno'] : null,
                            decoration: InputDecoration(
                              labelText: 'Contact No',
                            ),
                          ),
                          RaisedButton(
                            child: Text('Save Address'),
                            onPressed: _trySubmit,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
