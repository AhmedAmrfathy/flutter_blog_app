import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/providers/groupview_provider.dart';
import 'package:flutterapp/screens/homeview_screen.dart';
import 'package:flutterapp/widgets/group_widget.dart';
import 'package:flutterapp/widgets/groupactivity_widget.dart';
import 'package:provider/provider.dart';

class GroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return ListView(
      children: <Widget>[
        Container(
          width: devicesize.width,
          height: devicesize.height * .4,
          padding: EdgeInsets.only(left: 18, top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: devicesize.width,
                height: ScreenUtil().setHeight(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Groups',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
                    ),
                    Spacer(),
                    Container(
                      width: ScreenUtil().setWidth(35),
                      height: ScreenUtil().setHeight(35),
                      margin:
                          EdgeInsets.only(right: ScreenUtil().setHeight(10)),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(200, 200, 200, 1)),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: ScreenUtil().setHeight(30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Consumer<GroupViewProvider>(
                  builder: (ctx, data, child) => Container(
                        width: devicesize.width,
                        height: ScreenUtil().setHeight(50),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) => GroupAvtivityWidget(
                            title: data.activitylist[index].title,
                            icon: data.activitylist[index].icon,
                          ),
                          itemCount: data.activitylist.length,
                        ),
                      )),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Consumer<GroupViewProvider>(
                      builder: (ctx, data, index) => ListView.builder(scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) => GroupWidget(
                          image: data.groups[index].image,
                          name: data.groups[index].name,
                        ),
                        itemCount: data.groups.length,
                      ),
                    )),
              )
            ],
          ),
        ),
        HomeView.postswidget()
      ],
    );
  }
}
