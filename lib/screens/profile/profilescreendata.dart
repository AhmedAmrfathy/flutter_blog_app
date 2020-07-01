import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/models/story.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:flutterapp/screens/homeview/homeview_screen.dart';
import 'package:flutterapp/screens/profile/profilescreen.dart';
import 'package:flutterapp/widgets/post/post_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreenData extends StatefulWidget {
  @override
  _ProfileScreenDataState createState() => _ProfileScreenDataState();
}

class _ProfileScreenDataState extends State<ProfileScreenData> {
  Future<void> future;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = Provider.of<HomeViewProvider>(context, listen: false)
        .getPosts(sharing: true);
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final user = Provider.of<ProfileScreenProvider>(context);
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);

    List<String> list = [
      'https://7nen.net/wp-content/uploads/2019/07/2544.jpg',
      'https://i2.wp.com/www.newphotodownload.info/wp-content/uploads/2019/12/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%B5%D8%BA%D8%A7%D8%B1-2020-35.jpg?ssl=1',
      'https://i2.wp.com/www.newphotodownload.info/wp-content/uploads/2019/12/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%B5%D8%BA%D8%A7%D8%B1-2020-35.jpg?ssl=1',
      'https://i2.wp.com/www.newphotodownload.info/wp-content/uploads/2019/12/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%B5%D8%BA%D8%A7%D8%B1-2020-35.jpg?ssl=1',
      'https://i2.wp.com/www.newphotodownload.info/wp-content/uploads/2019/12/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%B5%D8%BA%D8%A7%D8%B1-2020-35.jpg?ssl=1',
      'https://i2.wp.com/www.newphotodownload.info/wp-content/uploads/2019/12/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%B5%D8%BA%D8%A7%D8%B1-2020-35.jpg?ssl=1'
    ];
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: devicesize.width,
            height: devicesize.height * .06,
            padding: EdgeInsets.only(top: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                    size: 24,
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: devicesize.width - 70,
                  padding: EdgeInsets.only(left: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Search',
                                labelStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(18),
                                    color: Colors.grey)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            color: Colors.black87,
            thickness: .4,
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    width: devicesize.width,
                    height: devicesize.height * .6,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: devicesize.width,
                          height: devicesize.height * .3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                                  ),
                                  fit: BoxFit.fill)),
                        ),
                        Positioned(
                          bottom: ScreenUtil().setHeight(100),
                          left: ScreenUtil().setHeight(130),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.redAccent)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          user.profilepic==null?'https://skillquo.com/wp-content/uploads/2016/10/user-avatar.png':user.profilepic,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  user.username==null?'new user':user.username,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(27),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'be Strong man',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 50,
                          child: Container(
                            width: devicesize.width * .7,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                              20,
                            )),
                            child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                'Add To Story',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(17)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Divider(
                              color: Colors.black54,
                              thickness: 1,
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  Container(
                    width: devicesize.width,
                    height: devicesize.height * .33,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Dataelemnt(
                            devicesize: devicesize,
                            icon: Icons.home,
                            text1: 'Lives in',
                            text2: ' Mansoura',
                          ),
                        ),
                        Expanded(
                          child: Dataelemnt(
                            devicesize: devicesize,
                            icon: Icons.favorite,
                            text1: ' State',
                            text2: ' Single',
                          ),
                        ),
                        Expanded(
                          child: Dataelemnt(
                            devicesize: devicesize,
                            icon: Icons.notifications,
                            text1: 'Followed by ',
                            text2: '45 people',
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ProfileScreen()));
                            },
                            child: Container(
                              width: devicesize.width,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: Text(
                                  'Edit Public Details',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18),
                                      color: Colors.blueAccent),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(204, 229, 255, .8),
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setHeight(12))),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Divider(
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: devicesize.width,
                    height: devicesize.height * .5,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: devicesize.width,
                          height: devicesize.height * .1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Photos',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(22),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Show all photo',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: ScreenUtil().setSp(15)),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 3 / 3),
                              itemBuilder: (ctx, index) {
                                return PhotoWidget(list[index]);
                              },
                              itemCount: list.length,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: devicesize.width,
                    height: devicesize.height * .28,
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: devicesize.width,
                          height: devicesize.height * .1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Posts',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(25),
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Container(
                                height: ScreenUtil().setHeight(40),
                                width: ScreenUtil().setHeight(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color.fromRGBO(224, 224, 224, .6),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.repeat,
                                    size: ScreenUtil().setHeight(18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: ScreenUtil().setHeight(40),
                                width: ScreenUtil().setHeight(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color.fromRGBO(224, 224, 224, .6),
                                ),
                                child: Center(
                                  child: Icon(Icons.settings,
                                      size: ScreenUtil().setHeight(18)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  width: devicesize.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(44),
                                        height: ScreenUtil().setHeight(44),
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(10)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            user.profilepic==null?'https://skillquo.com/wp-content/uploads/2016/10/user-avatar.png':user.profilepic,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                labelText:
                                                    'What`s on your mind?',
                                                contentPadding: EdgeInsets.only(
                                                    left: ScreenUtil()
                                                        .setHeight(17)))),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: icontext(
                                          Colors.red, Icons.video_call, 'Live'),
                                    ),
                                    VerticalDivider(),
                                    Expanded(
                                      child: icontext(Colors.lightGreen,
                                          Icons.photo_library, 'Photo'),
                                    ),
                                    VerticalDivider(),
                                    Expanded(
                                      child: icontext(Colors.redAccent,
                                          Icons.place, 'Check in'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: future,
                    builder: (ctx, snapshotdata) {
                      if (snapshotdata.connectionState ==
                          ConnectionState.done) {
                        return Consumer<HomeViewProvider>(
                          builder: (ctx, data, ch) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) =>
                                  ChangeNotifierProvider.value(
                                value: data.getsharingposts[index],
                                child: PostWidget(),
                              ),
                              itemCount: data.getsharingposts.length,
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class Dataelemnt extends StatelessWidget {
  final Size devicesize;
  final String text1;
  final String text2;
  final IconData icon;

  Dataelemnt({this.devicesize, this.text1, this.text2, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: devicesize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.grey,
              size: ScreenUtil().setHeight(27),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(5),
            ),
            Text(
              text1,
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setSp(18)),
            ),
            Text(
              text2,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}

class PhotoWidget extends StatelessWidget {
  final String imgurl;

  PhotoWidget(this.imgurl);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imgurl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
