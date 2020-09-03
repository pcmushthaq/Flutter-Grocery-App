import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constants.dart';
import 'package:grocery/widgets/allproducts.dart';
import '../widgets/account_body.dart';
import '../widgets/cart_body.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/home_body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  var _isLoading;
  FirebaseUser user;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
//        navigateToScreens(index);
    });
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      _isLoading = true;
    });
    user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _isLoading = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      Home(),
      AllProducts(),
      Cart(),
      AccountDetail(user)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        //elevation: 0,
        centerTitle: true,
        title: Text(
          "Delivery App",
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(
        //         Icons.notifications_none,
        //         color: Color(0xFF3a3737),
        //       ),
        //       onPressed: () {})
        // ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(color: Color(0xFF2c2b2b)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'All Products',
              style: TextStyle(color: Color(0xFF2c2b2b)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            title: Text(
              'Cart',
              style: TextStyle(color: Color(0xFF2c2b2b)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text(
              'Account',
              style: TextStyle(color: Color(0xFF2c2b2b)),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
