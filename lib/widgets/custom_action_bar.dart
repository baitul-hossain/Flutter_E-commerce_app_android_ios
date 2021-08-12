
import 'package:a_commerce/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;

  CustomActionBar({this.title, this.hasBackArrow, this.hasTitle});

  @override
  Widget build(BuildContext context) {

    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

    return Container(
      padding: EdgeInsets.only(
        top: 72.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasBackArrow)
            Container(
              width: 40.0,
              height: 40.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: Image(
                image: AssetImage(
                  'assets/images/back_arrow.png'
                ),
                color: Colors.white,
                width: 20.0,
                height: 20.0,
              ),
            ),
          if(_hasTitle)
            Text(
                title ?? 'Action bar',
              style: Constants.boldHeading,
            ),
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,

              ),
            ),
          )
        ],
      ),
    );
  }
}
