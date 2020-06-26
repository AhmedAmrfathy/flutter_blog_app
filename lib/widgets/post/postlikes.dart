import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:provider/provider.dart';

class PostLikessheet extends StatelessWidget {
  final String postid;
  final Size devicesize;

  PostLikessheet(this.postid, this.devicesize);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
 //   final post=Provider.of<Post>(context,listen: false);
    final allposts = Provider.of<HomeViewProvider>(context).getposts;
    final List<ProfileScreenProvider> speceficpostlikesuser =
        allposts.firstWhere((item) {
      return item.id == postid;
    }).userslikes;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      height: ScreenUtil().setHeight(400),
      width: devicesize.width,
      child: ListView.builder(
        itemBuilder: (ctx, index) => ListTile(
          leading: SizedBox(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(30),
            child: CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(speceficpostlikesuser[index].profilepic),
            ),
          ),
          title: Text(
            speceficpostlikesuser[index].username,
            style: TextStyle(
                color: Colors.black54, fontSize: ScreenUtil().setHeight(18)),
          ),
          trailing: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 20,
          ),
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: speceficpostlikesuser.length,
      ),
    );
  }
}
