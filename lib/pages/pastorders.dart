import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PastOrdersScreen extends StatelessWidget {
  static const routeName = '/pastorders';
  @override
  Widget build(BuildContext context) {
    var userId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Orders"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: Firestore.instance
                  .collection('users/' + userId + '/past orders')
                  .getDocuments(),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  QuerySnapshot query = snapshot.data;
                  List<DocumentSnapshot> docs = query.documents;
                  var orderList = docs.map((e) => e.data).toList();
                  if (orderList.isEmpty) {
                    return Text('No orders yet');
                  } else {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          //TODO do this
                          title: orderList[index]['item_name'],
                        );
                      },
                      itemCount: orderList.length,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
