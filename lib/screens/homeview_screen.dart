import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/providers/homeview_provider.dart';
import 'package:flutterapp/widgets/post_widget.dart';
import 'package:flutterapp/widgets/story_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  Widget icontext(Color color, IconData iconData, String word) {
    return FlatButton.icon(
        padding: EdgeInsets.all(1),
        icon: Icon(
          iconData,
          color: color,
          size: 24,
        ),
        label: Text(word));
  }

  Widget basecontainer(Size devicesize) {
    return Container(
        width: devicesize.width,
        height: devicesize.height * .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            firstbasewidget(devicesize),
            storywidget(devicesize),
          ],
        ));
  }

  Widget firstbasewidget(Size devicesize) {
    return Container(
      width: devicesize.width,
      height: devicesize.height * .15,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Container(
                width: ScreenUtil().setWidth(47),
                height: ScreenUtil().setHeight(47),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://ccute.cc/wp-content/uploads/2018/09/4454-4.jpg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              title: Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setHeight(43),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        labelText: 'What`s on your mind?',
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setHeight(17))),
                  )),
            ),
          ),
          Divider(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: icontext(Colors.red, Icons.video_call, 'Live'),
                ),
                VerticalDivider(),
                Expanded(
                  child:
                      icontext(Colors.lightGreen, Icons.photo_library, 'Photo'),
                ),
                VerticalDivider(),
                Expanded(
                  child: icontext(Colors.redAccent, Icons.place, 'Check in'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget storywidget(Size devicesize) {
    return Consumer<HomeViewProvider>(
      builder: (ctx, object, child) => Container(
          width: devicesize.width,
          height: devicesize.height * .33,
          margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(9)),
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(13),
              bottom: ScreenUtil().setHeight(10),
              left: ScreenUtil().setHeight(17)),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => StoryWidget(
                object.getstories[index].photo,
                object.getstories[index].text,
                object.getstories[index].circlephoto),
            itemCount: object.getstories.length,
          )),
    );
  }

  static Widget postswidget() {
    return Consumer<HomeViewProvider>(
      builder: (ctx, object, child) => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => PostWidget(
            circlephoto: object.getposts[index].circlephoto,
            personname: object.getposts[index].personname,
            posttime: object.getposts[index].posttime,
            numberofcomment: object.getposts[index].numberofcomment,
            postphoto: object.getposts[index].postphoto,
            posttext: object.getposts[index].posttext),
        itemCount: object.getposts.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return ListView(
      children: <Widget>[basecontainer(devicesize), postswidget()],
    );
  }
}
