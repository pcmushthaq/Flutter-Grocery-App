import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/widgets/product_tile.dart';

class DealofTheDayScreen extends StatelessWidget {
  static const routeName = '/dealoftheday';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deal of the Day'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: Firestore.instance
                  .collection('all products')
                  .where('dealofDay', isEqualTo: true)
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  QuerySnapshot query = snapshot.data;
                  List<DocumentSnapshot> docs = query.documents;
                  var dealList = docs.map((e) => e.data).toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.75),
                    itemBuilder: (context, index) {
                      var currProduct = dealList[index];
                      return ProductTile(
                        name: currProduct['name'],
                        quantity: currProduct['quantity'] == null
                            ? '1 unit'
                            : currProduct['quantity'],
                        imageUrl: currProduct['imageUrl'],
                        price: currProduct['sellingPrice'].toString(),
                      );
                    },
                    itemCount: dealList.length,
                  );
                }
              }),
        ),
      ),
    );
  }
}
