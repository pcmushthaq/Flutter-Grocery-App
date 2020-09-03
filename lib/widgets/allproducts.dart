import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constants.dart';
import 'package:grocery/pages/allproductsscreen.dart';

import 'product_tile.dart';

class AllProductsWidget extends StatefulWidget {
  @override
  _AllProductsWidgetState createState() => _AllProductsWidgetState();
}

class _AllProductsWidgetState extends State<AllProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          AllProductsTitle(),
          Expanded(
            child: AllProducts(),
          )
        ],
      ),
    );
  }
}

class AllProductsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "All Products",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AllProductsScreen.routeName);
            },
            child: Text(
              "See all",
              style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w100),
            ),
          )
        ],
      ),
    );
  }
}

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection('all products')
            .limit(8)
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            QuerySnapshot query = snapshot.data;
            List<DocumentSnapshot> docs = query.documents;
            var topDealList = docs.map((e) => e.data).toList();

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topDealList.length,
              itemBuilder: (ctx, index) {
                var currProduct = topDealList[index];
                return ProductTile(
                  name: currProduct['name'],
                  price: currProduct['sellingPrice'].toString(),
                  imageUrl: currProduct['imageUrl'],
                  quantity: currProduct['quantity'],
                );
              },
            );
          }
        });
  }
}
