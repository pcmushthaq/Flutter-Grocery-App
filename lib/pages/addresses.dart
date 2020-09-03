import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/pages/editaddress.dart';

class AddressScreen extends StatelessWidget {
  static const routeName = '/address';
  @override
  Widget build(BuildContext context) {
    var userId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Addresses"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditAddress.routename, arguments: [userId]);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: Firestore.instance
                  .collection('users/' + userId + '/saved addresses')
                  .getDocuments(),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  QuerySnapshot query = snapshot.data;
                  List<DocumentSnapshot> docs = query.documents;
                  var addressList = docs.map((e) => e.data).toList();
                  if (addressList.isEmpty) {
                    return Text('Add an address to continue');
                  } else {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(addressList[index]['line1']),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(EditAddress.routename, arguments: [
                                userId,
                                docs[index].documentID,
                                addressList[index]
                              ]);
                            },
                          ),
                        );
                      },
                      itemCount: addressList.length,
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
