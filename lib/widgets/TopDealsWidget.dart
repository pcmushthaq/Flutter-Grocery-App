import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constants.dart';
import 'package:grocery/pages/topdeals.dart';

import 'product_tile.dart';

class TopDealsWidget extends StatefulWidget {
  @override
  _TopDealsWidgetState createState() => _TopDealsWidgetState();
}

class _TopDealsWidgetState extends State<TopDealsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          TopDealsTitle(),
          Expanded(
            child: TopDeals(),
          )
        ],
      ),
    );
  }
}

class TopDealsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Top Deals",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, TopDealsScreen.routeName);
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

class TopDeals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection('all products')
            .where('topDeal', isEqualTo: true)
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
