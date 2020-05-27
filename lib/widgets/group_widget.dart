import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupWidget extends StatelessWidget {
  final String image;
  final String name;

  GroupWidget({this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(110),
          height: ScreenUtil().setHeight(100),
          margin: EdgeInsets.only(right: 7),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setHeight(45),
          child: AutoSizeText(
            name,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
