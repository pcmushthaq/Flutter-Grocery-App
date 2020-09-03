import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/pages/category_menu.dart';

class TopMenus extends StatefulWidget {
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: FutureBuilder(
          future: Firestore.instance
              .collection('product categories')
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              QuerySnapshot query = snapshot.data;
              List<DocumentSnapshot> docs = query.documents;
              var categoryList = docs.map((e) => e.data).toList();
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TopMenuTiles(
                    imageUrl: categoryList[index]['imageUrl'],
                    name: categoryList[index]['name'],
                    id: docs[index].documentID,
                  );
                },
                itemCount: categoryList.length,
              );
            }
          }),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String id;

  TopMenuTiles({
    Key key,
    @required this.name,
    @required this.id,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: [id, name]);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 25.0,
                offset: Offset(0.0, 0.75),
              ),
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 24,
                    height: 24,
                  )),
                )),
          ),
          Text(name,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
