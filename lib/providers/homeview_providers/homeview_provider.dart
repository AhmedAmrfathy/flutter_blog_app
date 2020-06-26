import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/postcomment.dart';
import 'package:flutterapp/models/story.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class HomeViewProvider with ChangeNotifier {
  final String userid;
  final String token;

  HomeViewProvider(this.userid, this.token, this._listpost);

  List<Story> _list = [
    Story(
        'https://ccute.cc/wp-content/uploads/2018/09/4454-4.jpg',
        'Add to story',
        'https://www.girlstiktok.com/wp-content/uploads/2020/04/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%A7%D9%86%D8%B3%D8%AA%D9%82%D8%B1%D8%A7%D9%85-3.png'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSZpG7IEZ2I7p0r5lHGG2_mr0dnEPwACfFKbC52NU_dIoXGaaEV&usqp=CAU',
        'Ibrahim mohamed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRGT6memzyms-dlkpAh3BIY8CV-UPDwo7SwZJ-mmPvtUvffPZHC&usqp=CAU'),
    Story('https://lovee.cc/wp-content/uploads/2019/08/11726.jpg', 'Mariam Ali',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-9Y-DkJQ3rbY-GCpUtQ25tp96evygNc3Z3sbslPRC-bHs-Wvo&usqp=CAU'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTG7mEw4mbUaBLCVWhmvwgy0BChfgKhRqgx4V5ppl_PdDBn1TuO&usqp=CAU',
        'Hossam Sayed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQGdR3evsiXmmC-aLjhfqrwDyF5msBZtQL6bwpw-EA_SUubRi9m&usqp=CAU'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSZpG7IEZ2I7p0r5lHGG2_mr0dnEPwACfFKbC52NU_dIoXGaaEV&usqp=CAU',
        'Ibrahim mohamed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRGT6memzyms-dlkpAh3BIY8CV-UPDwo7SwZJ-mmPvtUvffPZHC&usqp=CAU'),
    Story('https://lovee.cc/wp-content/uploads/2019/08/11726.jpg', 'Mariam Ali',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-9Y-DkJQ3rbY-GCpUtQ25tp96evygNc3Z3sbslPRC-bHs-Wvo&usqp=CAU'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTG7mEw4mbUaBLCVWhmvwgy0BChfgKhRqgx4V5ppl_PdDBn1TuO&usqp=CAU',
        'Hossam Sayed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQGdR3evsiXmmC-aLjhfqrwDyF5msBZtQL6bwpw-EA_SUubRi9m&usqp=CAU')
  ];

  List<Story> get getstories {
    return [..._list];
  }

  CarouselController _CarouselController = CarouselController();

  CarouselController get getcontroller {
    return _CarouselController;
  }

  changestory(String key) {
    if (key == 'next') {
      _CarouselController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else if (key == 'last') {
      _CarouselController.previousPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  List<Post> _listpost = [
//    Post(
//      circlephoto:
//          'https://www.girlstiktok.com/wp-content/uploads/2020/04/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%A7%D9%86%D8%B3%D8%AA%D9%82%D8%B1%D8%A7%D9%85-3.png',
//      personname: 'Amira Hassan',
//      posttime: '2',
//      numberofcomment: 5,
//      posttext: 'now we are want to have 1000 like for this fucken post',
//    ),
//    Post(
//        circlephoto:
//            'https://1.bp.blogspot.com/-7MrlRJygRoQ/XZiqJ3S_lbI/AAAAAAABsco/5zTOqq6v4pEAKmdQ5I-StLVMFVA6Z5GBgCLcBGAsYHQ/s1600/00.jpg',
//        personname: 'Amira Hassan',
//        posttime: '2',
//        numberofcomment: 5,
//        postphoto: 'https://ccute.cc/wp-content/uploads/2020/04/2924.jpg',
//        posttext: 'now we are want to have 1000 like for this fucken post'),
//    Post(
//        posttext: 'now we are want to have 1000 like for this fucken post',
//        circlephoto:
//            'https://1.bp.blogspot.com/-7MrlRJygRoQ/XZiqJ3S_lbI/AAAAAAABsco/5zTOqq6v4pEAKmdQ5I-StLVMFVA6Z5GBgCLcBGAsYHQ/s1600/00.jpg',
//        personname: 'Ahmed amr',
//        posttime: '2',
//        postvedio:
//            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
//    Post(
//        circlephoto:
//            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQghOjmfc7TAPZdhZhmoQLsLojmDw0Cr5KZ3OMZNssi_25Dj_0t&usqp=CAU',
//        personname: 'Amira Hassan',
//        posttime: '2',
//        numberofcomment: 5,
//        postphoto:
//            'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/97603370_2604854456440395_6822997501830758400_o.jpg?_nc_cat=106&_nc_sid=8024bb&_nc_ohc=nKfPzyMB76kAX_oZ1Ox&_nc_ht=scontent-hbe1-1.xx&oh=a629de9159655a4226d9a99f077c3947&oe=5EE0F491',
//        posttext: 'now we are want to have 1000 like for this fucken post')
  ];
  var isloading = false;

  get checkloading {
    return isloading;
  }

  List<VideoPlayerController> listofcontroller = [];

  List<Post> get getposts {
    return [..._listpost];
  }

  List<Post> get getvediospost {
    final List<Post> list = [];
    _listpost.forEach((item) {
      if (item.postvedio != null) {
        list.add(item);
      }
    });
    return list;
  }

  Future<void> initiatevedio() async {
    Future<void> initiator;
    await _listpost.forEach((item) {
      if (item.postvedio != null) {
        VideoPlayerController controller =
            VideoPlayerController.network(item.postvedio);
        initiator = controller.initialize();
        controller.setLooping(true);
        controller.setVolume(1.0);
        listofcontroller.add(controller);
      }
    });
    return initiator;
  }

  Future<void> addPost(Post post) async {
    isloading = true;
    notifyListeners();
    final url =
        'https://moonlit-premise-234610.firebaseio.com/posts.json?auth=$token';
    try {
      final response = await http.post(url,
          body: json.encode({
            'creatorid': userid,
            'userprofileimage': post.circlephoto,
            'username': post.personname,
            'posttext': post.posttext,
            'postimageurl': post.postphoto,
            'postvedio': post.postvedio,
            'posttime': post.posttime,
            'postlikes': post.likesnum,
            'postcomments': post.commentsnum,
            'userslikes': post.userslikes.map((val) {
              return {
                'id': val.id,
                'token': val.token,
                'profilepic': val.profilepic,
                'username': val.username
              };
            }).toList(),
            'userscomments': post.userscommnets.map((val) {
              return {
                'id': val.profileScreenProvider.id,
                'token': val.profileScreenProvider.token,
                'profilepic': val.profileScreenProvider.profilepic,
                'username': val.profileScreenProvider.username
              };
            }).toList(),
          }));
      final responsedata = json.decode(response.body);
      Post newpost = new Post(
        post.userslikes,
        post.userscommnets,
        id: responsedata['name'],
        circlephoto: post.circlephoto,
        personname: post.personname,
        posttime: post.posttime,
        postphoto: post.postphoto,
        posttext: post.posttext,
        postvedio: post.postvedio,
        likesnum: post.likesnum,
        commentsnum: post.commentsnum,
      );
      _listpost.add(newpost);
      isloading = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getPosts() async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/posts.json?auth=$token';
    final response = await http.get(url);
    Map<String, dynamic> responsedata =
        json.decode(response.body) as Map<String, dynamic>;
    print(responsedata);
    final favouriteurl =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$userid/favouritepost.json?auth=$token';
    final favouriteresponse = await http.get(favouriteurl);
    final favouritepostdata =
        json.decode(favouriteresponse.body) as Map<String, dynamic>;
    final List<Post> list = [];
    responsedata.forEach((postid, postdata) {
      //for each post
      List<ProfileScreenProvider> listt = List();
      List<PostComment> listofemptycomment = List();
      List<ProfileScreenProvider> listoflikesuser = List();
      if (postdata['userslikes'] != null) {
        var unformedlikesdata = postdata['userslikes'] as Map<String, dynamic>;
        unformedlikesdata.map((id, value) {
          return MapEntry(
              id,
              ProfileScreenProvider(
                  username: value['username'],
                  profilepic: value['profilepic'],
                  token: value['token'],
                  id: value['id']));
        }).forEach((id, user) {
          listoflikesuser.add(user);
        });
      }
      if (postdata['userscomments'] != null) {
        var unformeduserscomments =
            postdata['userscomments'] as Map<String, dynamic>;
        List<PostComment> formedcommentslist = List();
        var formeduserscomments = unformeduserscomments.map((userid, value) {
          return MapEntry(
              userid,
              ((value as Map<String, dynamic>).map((commentid, comment) {
                return MapEntry(
                    commentid,
                    PostComment(
                        ProfileScreenProvider(
                            profilepic: comment['profilepic'],
                            id: comment['id'],
                            token: comment['token'],
                            username: comment['username']),
                        commentimage: comment['commentimage'],
                        commenttext: comment['comment'],
                        commentid: commentid));
              })));
        });
        formeduserscomments.forEach((userid, value) {
          value.forEach((commentid, comment) {
            formedcommentslist.add(comment);
          });
        });
        listofemptycomment = formedcommentslist;
      }

//      formeduserscomments.values.toList().forEach((item) {
//        formedcommentslist.add(item.values);
//      });
//      print(formedcommentslist);
      // unformedlikesdata.map((userid,))

      Post post = Post(
          postdata['userslikes'] == null ? listt : listoflikesuser ?? listt,
          listofemptycomment,
          id: postid,
          circlephoto: postdata['userprofileimage'],
          posttime: postdata['posttime'],
          posttext: postdata['posttext'],
          isliked: favouritepostdata == null
              ? false
              : favouritepostdata[postid] ?? false,
          personname: postdata['username'],
          postphoto: postdata['postimageurl'],
          likesnum: postdata['postlikes'],
          commentsnum: postdata['postcomments']);

//          postdata['userslikes'][userid] == null
//              ? (postdata['userslikes'] as List<dynamic>)
//                  .map((value) => ProfileScreenProvider(id: value['id']))
//                  .toList()
      list.add(post);
    });
    _listpost = list;
    notifyListeners();
  }
}
