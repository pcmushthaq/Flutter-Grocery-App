import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as List;
    var id = args[0];
    var name = args[1];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: Firestore.instance
                .collection('product categories/' + id + '/Products')
                .getDocuments(),
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                QuerySnapshot query = snapshot.data;
                List<DocumentSnapshot> docs = query.documents;
                var productList = docs.map((e) => e.data).toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.75),
                  itemBuilder: (context, index) {
                    var currProduct = productList[index];
                    return ProductTile(
                      name: currProduct['name'],
                      quantity: currProduct['quantity'] == null
                          ? '1 unit'
                          : currProduct['quantity'],
                      imageUrl: currProduct['imageUrl'],
                      price: currProduct['sellingPrice'].toString(),
                    );
                  },
                  itemCount: productList.length,
                );
              }
            }),
      ),
    );
  }
}
