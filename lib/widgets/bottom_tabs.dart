
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {

  final int selectedTab;
  final Function(int) tabPressed;

  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: 'assets/images/tab_home.png',
            onPressed: (){
              setState(() {
                widget.tabPressed(0);
              });
            },
            isSelected: _selectedTab == 0 ? true: false,
          ),
          BottomTabBtn(
              imagePath: 'assets/images/tab_search.png',
              onPressed: (){
                setState(() {
                  widget.tabPressed(1);
                });
              },
              isSelected: _selectedTab == 1 ? true: false,
          ),
          BottomTabBtn(
              imagePath: 'assets/images/tab_saved.png',
              onPressed: (){
                setState(() {
                  widget.tabPressed(2);
                });
              },
              isSelected: _selectedTab == 2 ? true: false,
          ),
          BottomTabBtn(
              imagePath: 'assets/images/tab_logout.png',
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {

  final String imagePath;
  final bool isSelected;
  final Function onPressed;

  BottomTabBtn({this.imagePath, this.isSelected, this.onPressed});

  @override
  Widget build(BuildContext context) {

    bool _isSelected = isSelected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 22.0,
            horizontal: 16.0
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _isSelected ? Theme.of(context).accentColor : Colors.transparent,
              width: 2.0
            )
          )
        ),
        child: Image(
          image: AssetImage(
              imagePath ?? 'assets/images/tab_home.png'
          ),
          width: 22.0,
          height: 22.0,
          color: _isSelected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}

