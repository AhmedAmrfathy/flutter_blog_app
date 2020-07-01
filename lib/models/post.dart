import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/postcomment.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Post with ChangeNotifier {
  final String id;
  final String circlephoto;
  final String personname;
  final String posttime;
  final String postphoto;
  final String posttext;
  final String postvedio;
  List<ProfileScreenProvider> userslikes;
  List<PostComment> userscommnets;
  bool isshared;
  bool isliked;
  int likesnum;
  int commentsnum;

  Post(
    @required this.userslikes,
    @required this.userscommnets, {
    @required this.id,
    @required this.circlephoto,
    @required this.personname,
    @required this.posttime,
    this.postphoto,
    this.posttext,
    this.postvedio,
    @required this.likesnum = 0,
    this.commentsnum = 0,
    this.isliked = false,
        this.isshared=false
  });

  increaselikes(Post post, String userid, String token,
      ProfileScreenProvider profiledata) async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/posts/${post.id}/postlikes.json?auth=$token';
    if (isliked) {
      likesnum--;
      isliked = !isliked;
      notifyListeners();
    } else {
      likesnum++;
      isliked = !isliked;
      notifyListeners();
    }
    await http.put(url, body: json.encode(likesnum));
    final secondurl =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$userid/favouritepost/${post.id}.json?auth=$token';
    final response = await http.put(secondurl, body: json.encode(isliked));
    addinuserslikes(post, profiledata);
  }

  addinuserslikes(Post post, ProfileScreenProvider profiledata) async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/posts/${post.id}/userslikes/${profiledata.id}.json?auth=${profiledata.token}';
    if (isliked == true) {
      if(userslikes.indexWhere((item){
        return
        item.id==profiledata.id;
      })==-1){
        userslikes.add(ProfileScreenProvider(
            id: profiledata.id,
            token: profiledata.token,
            profilepic: profiledata.profilepic,
            username: profiledata.username));
        notifyListeners();
      }
      else{
        userslikes.removeWhere((item){
          return
          item.id==profiledata.id;
        });
        userslikes.add(ProfileScreenProvider(
            id: profiledata.id,
            token: profiledata.token,
            profilepic: profiledata.profilepic,
            username: profiledata.username));
        notifyListeners();

      }

      final response = await http.put(url,
          body: json.encode({
            'id': profiledata.id,
            'token': profiledata.token,
            'username': profiledata.username,
            'profilepic': profiledata.profilepic
          }));
    } else {
      userslikes.removeWhere((item) => item.id == profiledata.id);
      notifyListeners();
      final response = await http.delete(url);
    }
  }

  addcomment(Post post, PostComment postComment) async {
    commentsnum++;
    notifyListeners();
    final url =
        'https://moonlit-premise-234610.firebaseio.com/posts/${post.id}/postcomments.json?auth=${postComment.profileScreenProvider.token}';
   final responsee= await http.put(url, body: json.encode(commentsnum));
   print(json.decode(responsee.body));
    final secondurl =
        'https://moonlit-premise-234610.firebaseio.com/posts/${post.id}/userscomments/${postComment.profileScreenProvider.id}.json?auth=${postComment.profileScreenProvider.token}';
    final response = await http.post(secondurl,
        body: json.encode({
          'id': postComment.profileScreenProvider.id,
          'token': postComment.profileScreenProvider.token,
          'profilepic': postComment.profileScreenProvider.profilepic,
          'username': postComment.profileScreenProvider.username,
          'comment': postComment.commenttext,
          'commentimage': postComment.commentimage
        }));
    final responsedata = json.decode(response.body);
    postComment.commentid=responsedata['name'];
    userscommnets.add(postComment);
    notifyListeners();

  }
  switchSharing(){
    isshared=!isshared;
    notifyListeners();
  }
}
