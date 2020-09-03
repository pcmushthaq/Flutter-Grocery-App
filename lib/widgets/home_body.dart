import 'package:flutter/material.dart';
import 'package:grocery/widgets/DealsofDayWidget.dart';
import 'package:grocery/widgets/allproducts.dart';

import 'TopDealsWidget.dart';
import '../widgets/SearchWidget.dart';
import '../widgets/TopMenus.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchWidget(),
            TopMenus(),
            TopDealsWidget(),
            DealsofDayWidget(),
            AllProductsWidget()
          ],
        ),
      ),
    );
  }
}
