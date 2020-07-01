import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/helper.dart';
import 'package:flutterapp/providers/homeview_providers/posts/createpost_provider.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:flutterapp/screens/homeview/story/createstory_screen.dart';
import 'package:flutterapp/screens/homeview/story/stories_screen.dart';
import 'package:flutterapp/screens/profile/profilescreen.dart';
import 'package:flutterapp/screens/profile/profilescreendata.dart';
import 'package:flutterapp/widgets/createpost.dart';
import 'package:flutterapp/widgets/post/post_widget.dart';
import 'package:flutterapp/widgets/story_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/providers/homeview_providers/story/createstory_provider.dart';

class HomeView extends StatefulWidget {
  static Widget postswidget(
      BuildContext context,) {
    return FutureBuilder(
      future: Provider.of<HomeViewProvider>(context, listen: false).getPosts(),
      builder: (ctx, snapshotdata) {
        if (snapshotdata.connectionState == ConnectionState.done) {
          return Consumer<HomeViewProvider>(
            builder: (ctx, data, ch) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                  value: data.getposts[index],
                  child: PostWidget(

//                    circlephoto: data.getposts[index].circlephoto,
//                    posttime: data.getposts[index].posttime,
//                    posttext: data.getposts[index].posttext,
//                    postphoto: data.getposts[index].postphoto,
//                    personname: data.getposts[index].personname,
//                    numberofcomment: data.getposts[index].numberofcomment,
//                    postvedio: data.getposts[index].postvedio,
//                    videoPlayerController: data.listofcontroller.isEmpty
//                        ? null
//                        : data.listofcontroller[index],
                      ),
                ),
                itemCount: data.getposts.length,
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 10,
            ),
          );
        }
      },
    );
  }

  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {


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

  Widget basecontainer(
    Size devicesize,
    BuildContext context,
  ) {
    return Container(
        width: devicesize.width,
        height: devicesize.height * .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            firstbasewidget(devicesize, context),
            storywidget(devicesize,context),
          ],
        ));
  }

  Widget firstbasewidget(Size devicesize, BuildContext context) {
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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return ProfileScreenData();
                    }));
                  },
                  child: Consumer<ProfileScreenProvider>(
                    builder: (ctx, profiledata, ch) => CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(profiledata.profilepic ==
                              null
                          ? 'https://www.aljadeed.com/wp-content/plugins/all-in-one-seo-pack-pro/images/default-user-image.png'
                          : profiledata.profilepic),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              title: Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setHeight(43),
                  child: TextField(
                    onTap: () => showpostcreatepage(context, devicesize),
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

  Widget storywidget(
    Size devicesize,
      BuildContext context
  ) {
    return FutureBuilder(
      future: ft,
      builder: (ctx, snapshotdata) {
        if (snapshotdata.connectionState == ConnectionState.done) {
          return Consumer<HomeViewProvider>(
            builder: (ctx, object, child) {
              return Container(
                  width: devicesize.width,
                  height: devicesize.height * .33,
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(9)),
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(13),
                      bottom: ScreenUtil().setHeight(10),
                      left: ScreenUtil().setHeight(17)),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) => InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ChangeNotifierProvider(
                                  create: (ctx) => CreatStoryProvider(),
                                  child: CreateStoryScreen())));
                        } else {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (ctx, Animation<double> animation,
                                  Animation<double> secanimation) {
                                return StoriesScreen(object, index);
                              },
                              transitionDuration: Duration(seconds: 1),
                              transitionsBuilder: (ctx,
                                  Animation<double> animation,
                                  Animation<double> secanimation,
                                  Widget child) {
                                animation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOutQuad);
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                  alignment: Alignment.centerLeft,
                                );
                              }));
                        }
                      },
                      child: StoryWidget(
                        index==0?Provider.of<ProfileScreenProvider>(context,listen: false).profilepic==null?'https://skillquo.com/wp-content/uploads/2016/10/user-avatar.png':Provider.of<ProfileScreenProvider>(context,listen: false).profilepic:  object.getstories[index].image,
                          object.getstories[index].textStory==null?null:object.getstories[index].textStory,
                          object.getstories[index].userdata,index),
                    ),
                    itemCount: object.getstories.length,
                  ));
            },
          );
        } else  {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void showpostcreatepage(BuildContext context, Size devicesize) async {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setter) {
              return ChangeNotifierProvider(
                  create: (ctx) => CreatePostProvider(),
                  child: CreatePost(devicesize));
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return ListView(
      children: <Widget>[
        basecontainer(devicesize, context),
        HomeView.postswidget(
          context,
        ),
      ],
    );
  }
  Future<void>ft;

  @override
  void initState() {
    ft= Provider.of<HomeViewProvider>(context, listen: false).getStories();
  }
}
