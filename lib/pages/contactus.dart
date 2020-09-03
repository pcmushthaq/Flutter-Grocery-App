import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  static const routeName = '/contactus';
  void mailLaunch() async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'pcmushthaq@gmail.com',
        queryParameters: {'subject': 'Support,GroceryApp'});
    var url = _emailLaunchUri.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Us'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact Us'),
              RaisedButton(
                child: Text("Mail to us"),
                onPressed: mailLaunch,
              )
            ],
          ),
        ),
      ),
    );
  }
}
