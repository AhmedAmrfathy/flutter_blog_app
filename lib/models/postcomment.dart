import 'package:flutter/cupertino.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';

class PostComment {
 final  ProfileScreenProvider profileScreenProvider;
 final String commenttext;
 final String commentimage;
  String commentid;
 PostComment(this.profileScreenProvider,{this.commenttext,this.commentimage,this.commentid});

}
