import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;
  final String quantity;

  ProductTile(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.price,
      @required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(boxShadow: [
            /* BoxShadow(
              color: Color(0xFFfae3e2),
              blurRadius: 15.0,
              offset: Offset(0, 0.75),
            ),*/
          ]),
          child: Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Container(
                width: 150,
                height: 210,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Center(
                              child: Image.network(imageUrl,
                                  width: 130, //130,
                                  height: 140 //140,
                                  )),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            alignment: Alignment.topRight,
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 5, top: 5),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFfae3e2),
                                      blurRadius: 25.0,
                                      offset: Offset(0.0, 0.75),
                                    ),
                                  ]),
                              child: Icon(
                                Icons.favorite,
                                color: Color(0xFFfb3132),
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(name == null ? 'Not avilable' : name,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Container(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                  price == null
                                      ? 'Not available'
                                      : 'Rs ' + price,
                                  style: TextStyle(
                                      color: Color(0xFF6e6e71),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5, right: 10),
                          child: Text(quantity == null ? '1 unit' : quantity,
                              style: TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
