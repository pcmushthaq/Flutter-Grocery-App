import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  static const routeName = '/editprofile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _pickedImage;
  File _userImageFile;
  bool _isLoading = false;
  String userId;
  var _mobileNo = 0;
  var _userName = '';
  final picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();

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
    if (_userImageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(userId + '.jpg');

      await ref.putFile(_userImageFile).onComplete;

      final url = await ref.getDownloadURL();
      await Firestore.instance.collection('users').document(userId).updateData(
        {'mobile': _mobileNo, 'imageUrl': url, 'username': _userName},
      );
    } else {
      await Firestore.instance.collection('users').document(userId).updateData(
        {'mobile': _mobileNo, 'username': _userName},
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    setState(() {});
  }

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 95, maxWidth: 150);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    _userImageFile = _pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as List;
    Map userData = args[0];
    userId = args[1];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _trySubmit,
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage)
                                : NetworkImage(userData['imageUrl']),
                          ),
                          FlatButton.icon(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: _pickImage,
                            icon: Icon(Icons.image),
                            label: Text('Add Image'),
                          ),
                          TextFormField(
                            readOnly: true,
                            style: TextStyle(color: Colors.grey),
                            initialValue: userData['email'],
                            decoration: InputDecoration(
                                labelText: 'Email', enabled: false),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _userName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                            initialValue: userData['username'],
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 10 ||
                                  !(int.tryParse(value) is int)) {
                                return 'Please enter a valid mobile no';
                              }
                              return null;
                            },
                            initialValue: userData['mobile'].toString(),
                            decoration: InputDecoration(
                              labelText: 'Mobile',
                            ),
                            onSaved: (value) {
                              _mobileNo = int.parse(value);
                            },
                          ),
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
