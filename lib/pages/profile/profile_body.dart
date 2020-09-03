import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/pages/addresses.dart';
import 'package:grocery/pages/contactus.dart';
import 'package:grocery/pages/edit_profile.dart';
import 'package:grocery/pages/pastorders.dart';
import '../../size_config.dart';

import 'info.dart';
import 'profile_menu_item.dart';

class ProfileBody extends StatelessWidget {
  final Map userData;
  final String userId;
  ProfileBody(this.userData, this.userId);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            imageMode: userData['imageUrl'] == null ? true : false,
            image: userData['imageUrl'] == null
                ? "assets/images/pic.png"
                : userData['imageUrl'],
            name: userData['username'],
            email: userData['email'],
            mobile: userData['mobile'].toString(),
          ),
          SizedBox(height: SizeConfig.defaultSize * 2),
          ProfileMenuItem(
            icon: Icons.edit,
            title: "Edit Profile",
            press: () {
              Navigator.pushNamed(context, EditProfile.routeName,
                  arguments: [userData, userId]);
            },
          ), //20
          ProfileMenuItem(
            icon: Icons.location_city,
            title: "Saved Addresses",
            press: () {
              Navigator.pushNamed(context, AddressScreen.routeName,
                  arguments: userId);
            },
          ),

          ProfileMenuItem(
            icon: Icons.history,
            title: "Order History",
            press: () {
              Navigator.pushNamed(context, PastOrdersScreen.routeName,
                  arguments: userId);
            },
          ),
          ProfileMenuItem(
            icon: Icons.mail,
            title: "Contact Us",
            press: () {
              Navigator.pushNamed(context, ContactUs.routeName);
            },
          ),

          ProfileMenuItem(
            icon: Icons.exit_to_app,
            title: "Logout",
            press: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout?'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        FlatButton(
                          child: Text('Logout'),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                        ),
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
