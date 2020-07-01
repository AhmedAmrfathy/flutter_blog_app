import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/postcomment.dart';
import 'package:flutterapp/providers/authontication_screen_provider.dart';
import 'package:flutterapp/providers/home_provider.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/homeview_providers/posts/commentsheet.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:flutterapp/widgets/post/postcomment.dart';
import 'package:flutterapp/widgets/post/postlikes.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  const PostWidget({Key key, this.videoPlayerController}) : super(key: key);

//  final String circlephoto;
//  final String personname;
//  final String posttime;
//  final String postphoto;
//  final String posttext;
//  final String postvedio;
//  final VideoPlayerController videoPlayerController;
//  final int numberofcomment;
//
//  PostWidget(
//      {this.circlephoto,
//      this.personname,
//      this.posttime,
//      this.numberofcomment,
//      this.postphoto,
//      this.posttext,
//      this.postvedio,
//      this.videoPlayerController});

  Widget postactivitywidget(
      {String text,
      IconData iconData,
      int iconsize,
      Color iconcolor,
      Function func}) {
    return Container(
        child: FlatButton.icon(
            onPressed: () {
              func();
            },
            icon: Icon(
              iconData,
              size: ScreenUtil().setHeight(iconsize),
              color: iconcolor,
            ),
            label: Text(
              text,
              style: TextStyle(
                  color: Color.fromRGBO(130, 130, 130, 1),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w700),
            )));
  }

  void showlikessheet(BuildContext context, String id, Size devicesize) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return PostLikessheet(id, devicesize);
        });
  }

  void showcommentsheet(
    BuildContext context,
    Size devicesize,
    CommentSheet commentSheetdata,
    Post post,
    ProfileScreenProvider profileScreenProvider,
  ) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: ScreenUtil().setHeight(600),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    width: devicesize.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: devicesize.width,
                          height: ScreenUtil().setHeight(50),
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'be The First to Like this post',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18)),
                                ),
                              ),
                              Spacer(),
                              StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setstate) {
                                  return IconButton(
                                    icon: Icon(
                                      post.isliked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: ScreenUtil().setHeight(30),
                                      color: post.isliked
                                          ? Colors.blue
                                          : Colors.black54,
                                    ),
                                    onPressed: () async {
                                      post.increaselikes(
                                          post,
                                          profileScreenProvider.id,
                                          profileScreenProvider.token,
                                          profileScreenProvider);
                                      setstate(() {});
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setstate) {
                            commentSheetdata.liststate = setstate;
                            return Expanded(
                              child: Container(
                                width: devicesize.width,
                                child: ListView.builder(
                                  itemCount: post.userscommnets.length,
                                  itemBuilder: (ctx, index) {
                                    return PostCommentWidget(
                                        post.userscommnets[index]);
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setstate) {
                    commentSheetdata.imagestate = setstate;
                    if (commentSheetdata.image != null) {
                      return Container(
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setHeight(100),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  commentSheetdata.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                top: -8,
                                left: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: ScreenUtil().setHeight(20),
                                  ),
                                  onPressed: () {
                                    commentSheetdata.image = null;
                                    commentSheetdata.imagestate(() {});
                                  },
                                ),
                              )
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: devicesize.width,
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          color: Colors.black54,
                          iconSize: ScreenUtil().setHeight(20),
                          onPressed: () async {
                            await commentSheetdata.getImage(
                                profileScreenProvider.id,
                                post.id,
                                profileScreenProvider.token);
                            commentSheetdata.imagestate(() {});
                          },
                        ),
                        Flexible(
                          child: TextField(
                            controller: commentSheetdata.textEditingController,
                            decoration: InputDecoration(
                                hintText: 'comment',
                                contentPadding: EdgeInsets.only(top: 8)),
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send,
                              color: Colors.blue,
                              size: ScreenUtil().setHeight(24)),
                          onPressed: () async {
                            await commentSheetdata.uploadImage();
                            PostComment comment = PostComment(
                                profileScreenProvider,
                                commenttext:
                                    commentSheetdata.textEditingController.text,
                                commentimage: commentSheetdata.commentimage);
                            await post.addcomment(post, comment);
                            commentSheetdata.image = null;
                            commentSheetdata.textEditingController.text = '';
                            commentSheetdata.imagestate(() {});
                            commentSheetdata.liststate(() {});
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final postdata = Provider.of<Post>(context, listen: false);
    final authdata = Provider.of<AuthonticationScreenProvider>(context);
    final profiledata = Provider.of<ProfileScreenProvider>(context);
    final homescreenprovider =
        Provider.of<HomeProvider>(context, listen: false);
    final commentSheetdata = Provider.of<CommentSheet>(context, listen: false);
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
                    backgroundImage: NetworkImage(postdata.circlephoto),
                  ),
                ),
                title: Text(
                  postdata.personname,
                  style: TextStyle(
                      fontSize:
                          ScreenUtil().setSp(17, allowFontScalingSelf: true),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(HelperMethod.getduration(postdata.posttime)),
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
                  postdata.posttext,
                  style:
                      TextStyle(fontSize: ScreenUtil().setSp(18), height: 1.1),
                ),
              ),
              Wrap(
                children: <Widget>[
                  if (postdata.postphoto != null)
                    Image.network(
                      postdata.postphoto,
                      fit: BoxFit.fill,
                    ),
                  if (videoPlayerController != null)
                    Stack(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(videoPlayerController),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            videoPlayerController.play();
                          },
                        )
                      ],
                    ),
                  Container(
                    width: devicesize.width,
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(6),
                    ),
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Consumer<Post>(
                            builder: (ctx, data, ch) => data.commentsnum == 0
                                ? Text('')
                                : Text(
                                    '${data.commentsnum.toString()} comments',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(15)),
                                  ),
                          ),
                        ),
                        Spacer(),
                        Consumer<Post>(
                          builder: (ctx, data, ch) => postactivitywidget(
                              text: data.likesnum.toString(),
                              iconData: Icons.favorite,
                              iconcolor: Colors.red,
                              iconsize: 20,
                              func: () {
                                showlikessheet(
                                    context, postdata.id, devicesize);
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: devicesize.width,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       Expanded(
                         child: Consumer<Post>(builder: (ctx,data,ch){
                           return postdata.isshared?Center(
                             child: Loading(indicator: BallPulseIndicator(),color: Colors.pink),
                           ):
                           postactivitywidget(
                               text: 'مشاركه',
                               iconData: Icons.forward_5,
                               iconsize: 30,
                               iconcolor: Colors.black54,func: () async{
                                 data.switchSharing();
                             await  Provider.of<HomeViewProvider>(context,listen: false).sharePost(postdata.id);
                             data.switchSharing();
                           });
                         },),
                       ),
                        Expanded(
                          child: postactivitywidget(
                              text: 'تعليق',
                              iconData: Icons.message,
                              iconsize: 30,
                              iconcolor: Colors.black54,
                              func: () {
                                showcommentsheet(
                                    homescreenprovider.context,
                                    devicesize,
                                    commentSheetdata,
                                    postdata,
                                    profiledata);
                              }),
                        ),
                        Consumer<Post>(
                          builder: (ctx, data, child) => Expanded(
                              child: FlatButton.icon(
                                  onPressed: () async {
                                    await postdata.increaselikes(
                                        postdata,
                                        authdata.userid,
                                        authdata.token,
                                        profiledata);
                                  },
                                  icon: Image.asset(
                                    'assets/images/like.png',
                                    color: data.isliked
                                        ? Colors.blue
                                        : Colors.black54,
                                    height: 30,
                                    width: 24,
                                  ),
//                                  icon: Icon(
//                                    data.isliked
//                                        ? Icons.favorite
//                                        : Icons.favorite_border,
//                                    size: ScreenUtil().setHeight(30),
//                                    color: data.isliked
//                                        ? Colors.blue
//                                        : Colors.black54,
//                                  ),
                                  label: Text(
                                    'أعجبنى',
                                    style: data.isliked
                                        ? TextStyle(
                                            color: Colors.blue,
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w700)
                                        : TextStyle(
                                            color: Color.fromRGBO(
                                                130, 130, 130, 1),
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w700),
                                  ))),
                        ),
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
