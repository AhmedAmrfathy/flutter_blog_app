import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatelessWidget {
  final String circlephoto;
  final String personname;
  final String posttime;
  final String postphoto;
  final String posttext;
  final String postvedio;
  final VideoPlayerController videoPlayerController;
  final int numberofcomment;

  PostWidget(
  { this.circlephoto, this.personname, this.posttime, this.numberofcomment,
    this.postphoto,
    this.posttext,
    this.postvedio,
    this.videoPlayerController});

  Widget postactivitywidget(String text, IconData iconData) {
    return Expanded(
        child: FlatButton.icon(
            icon: Icon(
              iconData,
              size: ScreenUtil().setHeight(30),
              color: Color.fromRGBO(130, 130, 130, 1),
            ),
            label: Text(
              text,
              style: TextStyle(
                  color: Color.fromRGBO(130, 130, 130, 1),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w700),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Container(
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(50),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(circlephoto),
                  ),
                ),
                title: Text(
                  personname,
                  style: TextStyle(
                      fontSize:
                          ScreenUtil().setSp(17, allowFontScalingSelf: true),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(posttime + 'm'),
                    SizedBox(
                      width: ScreenUtil().setWidth(5),
                    ),
                    Icon(
                      Icons.group,
                      size: ScreenUtil().setHeight(20),
                    )
                  ],
                ),
                trailing: Padding(
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    child: Icon(
                      Icons.power_input,
                      size: ScreenUtil().setHeight(20),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(6)),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    right: ScreenUtil().setWidth(13)),
                child: Text(
                  ' السلام عليكم ورحمة الله وبركاته هذا النص هو مثال صغير على ما يمكن كتابته فى هذا المربع الخاص بالكتابه',
                  style:
                      TextStyle(fontSize: ScreenUtil().setSp(18), height: 1.1),
                ),
              ),
              Wrap(
                children: <Widget>[
                  postphoto != null
                      ? Image.network(
                          postphoto,
                          fit: BoxFit.fill,
                        )
                      :Stack(children: <Widget>[
                    AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                    IconButton(icon:Icon(Icons.play_arrow,size: 40,color: Colors.redAccent,),onPressed: (){
                      videoPlayerController.play();
                    },)
                  ],) ,
                  Container(
                    width: devicesize.width,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        postactivitywidget('مشاركه', Icons.forward_5),
                        postactivitywidget('تعليق', Icons.message),
                        postactivitywidget('أعجبنى', Icons.favorite_border),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
