import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key key,
    this.icon,
    this.title,
    this.press,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultSize * 2, vertical: defaultSize * 3),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: kTextLigntColor,
              ),
              SizedBox(width: defaultSize * 2),
              Text(
                title,
                style: TextStyle(
                  fontSize: defaultSize * 1.6, //16
                  color: kTextLigntColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: defaultSize * 1.6,
                color: kTextLigntColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
