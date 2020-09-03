import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/constants.dart';
import 'package:grocery/pages/addresses.dart';
import 'package:grocery/pages/allproductsscreen.dart';
import 'package:grocery/pages/category_menu.dart';
import 'package:grocery/pages/contactus.dart';
import 'package:grocery/pages/dealsofday.dart';
import 'package:grocery/pages/edit_profile.dart';
import 'package:grocery/pages/editaddress.dart';
import 'package:grocery/pages/pastorders.dart';
import 'package:grocery/pages/topdeals.dart';

import './pages/FoodDetailsPage.dart';
import './pages/FoodOrderPage.dart';
import './pages/HomePage.dart';

import './pages/auth_screen.dart';
import './pages/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Roboto',
          hintColor: Color(0xFFd0cece),
          primaryColor: kPrimaryColor,
          accentColor: Colors.blueGrey[900]),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return HomePage();
            }
            return AuthScreen();
          }),
      routes: {
        FoodDetailsPage.routeName: (ctx) => FoodDetailsPage(),
        FoodOrderPage.routeName: (ctx) => FoodOrderPage(),
        CategoryScreen.routeName: (ctx) => CategoryScreen(),
        TopDealsScreen.routeName: (ctx) => TopDealsScreen(),
        DealofTheDayScreen.routeName: (ctx) => DealofTheDayScreen(),
        EditProfile.routeName: (ctx) => EditProfile(),
        ContactUs.routeName: (ctx) => ContactUs(),
        AddressScreen.routeName: (ctx) => AddressScreen(),
        PastOrdersScreen.routeName: (ctx) => PastOrdersScreen(),
        EditAddress.routename: (ctx) => EditAddress(),
        AllProductsScreen.routeName: (ctx) => AllProductsScreen()
      },
    );
  }
}
