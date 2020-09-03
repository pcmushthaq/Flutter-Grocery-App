import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/pages/profile/profile_body.dart';

class AccountDetail extends StatelessWidget {
  final FirebaseUser user;
  AccountDetail(this.user);

  @override
  Widget build(BuildContext context) {
    var userid = user.uid;
    return FutureBuilder(
        future: Firestore.instance.collection('users').document(userid).get(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            DocumentSnapshot snap = snapshot.data;
            Map userData = snap.data;

            return ProfileBody(userData, userid);
          }
        });
  }
}
