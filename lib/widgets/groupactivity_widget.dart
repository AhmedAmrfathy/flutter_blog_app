import 'package:flutter/material.dart';

class GroupAvtivityWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  GroupAvtivityWidget({this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(220, 220, 220, .8),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.only(right: 7),
          child: FlatButton.icon(
            icon: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
            label: Text(
             title,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
