import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/providers/homeview_providers/posts/createpost_provider.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:provider/provider.dart';

import '../helper.dart';

class CreatePost extends StatelessWidget {
  final Size devicesize;

  CreatePost(this.devicesize);

  Widget topWidget(
      {Widget tabpar,
      Widget postowner,
      BuildContext context,
      CreatePostProvider CreatePostdata,
      ProfileScreenProvider profiledata,
      HomeViewProvider postsproviderobject}) {
    return Container(
      width: devicesize.width,
      height: devicesize.height * .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[tabpar, postowner],
      ),
    );
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  @override
  Widget build(BuildContext context) {
    final CreatePostdata = Provider.of<CreatePostProvider>(context);
    final postsproviderobject = Provider.of<HomeViewProvider>(context);
    final profiledata = Provider.of<ProfileScreenProvider>(context);
    Widget tabpar = Expanded(
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(7)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: ScreenUtil().setHeight(24),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Text(
                  'Create Post',
                  style: TextStyle(
                      color: Helper.color['black'],
                      fontSize: ScreenUtil().setSp(20)),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setHeight(9)),
                  child: InkWell(
                    onTap: () async {
                      await CreatePostdata.uploadImage();
                      Post post = Post(
                        [],
                        [],
                          posttext: CreatePostdata.textEditingController.text,
                          postphoto: CreatePostdata.imageurl,
                          posttime: DateTime.now().toString(),
                          circlephoto: profiledata.profilepic,
                          personname: profiledata.username,
                      );
                      try {
                        await postsproviderobject.addPost(post);
                      } catch (error) {
                        await HelperMethod.showerrordialog(
                            'sorry an error has occured', context);
                        Navigator.of(context).pop();
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'POST',
                      style: TextStyle(
                          color: Helper.color['black'],
                          fontSize: ScreenUtil().setSp(17)),
                    ),
                  ))
            ],
          ),
        ),
        Spacer(),
        Divider(
          color: Helper.color['black'],
          height: 1,
        )
      ],
    ));
    Widget postowner = Expanded(
      child: Center(
        child: ListTile(
            leading: Container(
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(40),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(profiledata.profilepic == null
                    ? 'https://unaryteam.com/ar/wp-content/themes/atomlab/assets/images/avatar-placeholder.jpg'
                    : profiledata.profilepic),
              ),
            ),
            title: Text(
              profiledata.username == null ? 'new user' : profiledata.username,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  color: Helper.color['black'],
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(80),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.public,
                        size: ScreenUtil().setHeight(20),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Text(
                        'Public',
                        style: TextStyle(
                            color: Helper.color['black'],
                            fontSize: ScreenUtil().setSp(15)),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
    Widget posttextfieldwidget = Container(
      child: Wrap(
        children: <Widget>[
          Container(
              width: devicesize.width - 10,
              height: 300,
              padding: EdgeInsets.only(left: ScreenUtil().setHeight(10)),
              child: TextField(
                controller: CreatePostdata.textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What\'s on your mind ? ',
                  hintStyle: TextStyle(fontSize: ScreenUtil().setSp(21)),
                ),
                maxLines: 20,
              )),
        ],
      ),
    );
    Widget postimagewidget = Center(
      child: CreatePostdata.image == null
          ? Column(
              children: <Widget>[
                Text('No image selected.'),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    CreatePostdata.getImage();
                  },
                )
              ],
            )
          : Image.file(
              CreatePostdata.image,
              fit: BoxFit.fill,
              width: 400,
              height: 200,
            ),
    );

    return postsproviderobject.checkloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: devicesize.width,
            height: devicesize.height,
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  topWidget(
                      tabpar: tabpar,
                      postowner: postowner,
                      context: context,
                      CreatePostdata: CreatePostdata,
                      postsproviderobject: postsproviderobject,
                      profiledata: profiledata),
                  posttextfieldwidget,
                  postimagewidget
                ],
              ),
            ),
          );
  }
}
