import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/widgets/product_tile.dart';

class AllProductsScreen extends StatelessWidget {
  static const routeName = '/allproducts';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future:
                  Firestore.instance.collection('all products').getDocuments(),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  QuerySnapshot query = snapshot.data;
                  List<DocumentSnapshot> docs = query.documents;
                  var productsList = docs.map((e) => e.data).toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.75),
                    itemBuilder: (context, index) {
                      var currProduct = productsList[index];
                      return ProductTile(
                        name: currProduct['name'],
                        quantity: currProduct['quantity'] == null
                            ? '1 unit'
                            : currProduct['quantity'],
                        imageUrl: currProduct['imageUrl'],
                        price: currProduct['sellingPrice'].toString(),
                      );
                    },
                    itemCount: productsList.length,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
