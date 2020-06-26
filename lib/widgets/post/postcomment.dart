import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/models/postcomment.dart';

class PostCommentWidget extends StatelessWidget {
  final PostComment comment;

  PostCommentWidget(this.comment);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery
        .of(context)
        .size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: SizedBox(
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(30),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    comment.profileScreenProvider.profilepic == null
                        ? ''
                        : comment.profileScreenProvider.profilepic),
              ),
            ),
            title: Text(
              comment.profileScreenProvider.username,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20), color: Colors.black),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                comment.commenttext,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: ScreenUtil().setSp(17),
                ),
                maxLines: 2,
                softWrap: true,
              ),
            ),
          ),
          if(comment.commentimage != null)
            Container(margin: EdgeInsets.only(right: 200),
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  comment.commentimage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
        ],
      ),

    );
  }}