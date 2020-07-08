import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/postcomment.dart';
import 'package:flutterapp/models/story.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class HomeViewProvider with ChangeNotifier {
  final String userid;
  final String token;
  final String profileimg;
  final String username;

  HomeViewProvider(this.userid, this.token, this.profileimg, this.username,
      this._listpost, this._list);

  List<Story> _list = [];

  List<Story> get getstories {
    return [..._list];
  }

  Future<void> addStory(Story story) async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/stories.json?auth=$token';
    Map object;
    if (story.image != null) {
      object = {
        'creatorid': userid,
        'userdata': {
          'username': story.userdata.username,
          'profilepic': story.userdata.profilepic,
        },
        'storyimg': story.image,
        'datetime': DateTime.now().toString()
      };
    } else {
      object = {
        'creatorid': userid,
        'datetime': DateTime.now().toString(),
        'userdata': {
          'username': story.userdata.username,
          'profilepic': story.userdata.profilepic,
        },
        'textstory': {
          'storytext': story.textStory.text,
          'storybackground': story.textStory.backgroundcolor.value,
          'storyfontcolor': story.textStory.fontcolor.value
        },
      };
    }
    final response = await http.post(url, body: json.encode(object));
    await getStories();
    notifyListeners();

    if (response.statusCode == 200) {}
  }

  Future<void> getStories() async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/stories.json?auth=$token';
    final response = await http.get(url);
    final responsedata = json.decode(response.body);
    print(responsedata);
    if (responsedata == null) {
      Story story = Story(userid,
          ProfileScreenProvider(username: username, profilepic: profileimg),
          image: profileimg,
          textStory: TextStory(
            text: '',
          ));
      await addStory(story);
      final secresponse = await http.get(url);
      final data = json.decode(secresponse.body) as Map<String, dynamic>;
      final List<Story> storylis = [];
      Map<String, Story> formedmap = data.map((storyid, jsonstory) {
        return MapEntry(
            storyid,
            Story(
                storyid,
                ProfileScreenProvider(
                    username: (jsonstory['userdata']
                        as Map<String, String>)['username'],
                    profilepic: (jsonstory['userdata']
                        as Map<String, String>)['profilepic']),
                image: jsonstory['storyimg'] == null
                    ? null
                    : jsonstory['storyimg'],
                textStory: jsonstory['storytext'] == null
                    ? null
                    : jsonstory['storytext'],
                datetime: jsonstory['datetime']));
      });
      formedmap.forEach((key, story) {
        storylis.add(story);
      });
      _list.addAll(storylis);
      notifyListeners();
    } else {
      final secresponse = await http.get(url);
      final data = json.decode(secresponse.body) as Map<String, dynamic>;
      final List<Story> storylis = [];
      Map<String, Story> formedmap = data.map((storyid, jsonstory) {
        return MapEntry(
            storyid,
            Story(
                storyid,
                ProfileScreenProvider(
                    username: (jsonstory['userdata']
                        as Map<String, dynamic>)['username'],
                    profilepic: (jsonstory['userdata']
                        as Map<String, dynamic>)['profilepic']),
                image: jsonstory['storyimg'] == null
                    ? null
                    : jsonstory['storyimg'],
                textStory: jsonstory['textstory'] == null
                    ? null
                    : TextStory(
                        text: (jsonstory['textstory']
                            as Map<String, dynamic>)['storytext'],
                        fontcolor: Color((jsonstory['textstory']
                            as Map<String, dynamic>)['storyfontcolor']),
                        backgroundcolor: Color(
                            (jsonstory['textstory'] as Map<String, dynamic>)['storybackground'])),
                datetime: jsonstory['datetime']));
      });
      formedmap.forEach((key, story) {
        storylis.add(story);
      });
      _list.clear();
      _list.addAll(storylis);
      notifyListeners();
    }
  }

  CarouselController _CarouselController = CarouselController();

  CarouselController get getcontroller {
    return _CarouselController;
  }

  changestory(String key) {
    if (key == 'next') {
      _CarouselController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInSine);
    } else if (key == 'last') {
      _CarouselController.previousPage(
          duration: Duration(milliseconds: 200), curve: Curves.decelerate);
    }
  }

  List<Post> _listpost = [];
  List<Post> _sharinglistpost = [];
  var isloading = false;

  get checkloading {
    return isloading;
  }

  List<VideoPlayerController> listofcontroller = [];

  List<Post> get getposts {
    return [..._listpost];
  }

  List<Post> get getsharingposts {
    return [..._sharinglistpost];
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
      final securl =
          'https://moonlit-premise-234610.firebaseio.com/users/secretdata/usersshares/$userid/${responsedata['name']}.json?auth=$token';
      final secresponse = await http.put(securl,
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
      _listpost.add(newpost);
      _sharinglistpost.add(newpost);
      isloading = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getPosts({bool sharing = false}) async {
    final url = sharing
        ? 'https://moonlit-premise-234610.firebaseio.com/users/secretdata/usersshares/$userid.json?auth=$token'
        : 'https://moonlit-premise-234610.firebaseio.com/posts.json?auth=$token';
    final response = await http.get(url);
    Map<String, dynamic> responsedata =
        json.decode(response.body) as Map<String, dynamic>;
    final favouriteurl =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$userid/favouritepost.json?auth=$token';
    final favouriteresponse = await http.get(favouriteurl);
    final favouritepostdata =
        json.decode(favouriteresponse.body) as Map<String, dynamic>;
    final List<Post> list = [];
    if (responsedata == null) {
      sharing ? _sharinglistpost = list : _listpost = list;
      notifyListeners();
    } else {
      responsedata.forEach((postid, postdata) {
        //for each post
        List<ProfileScreenProvider> listt = List();
        List<PostComment> listofemptycomment = List();
        List<ProfileScreenProvider> listoflikesuser = List();
        if (postdata['userslikes'] != null) {
          var unformedlikesdata =
              postdata['userslikes'] as Map<String, dynamic>;
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
        list.add(post);
      });
      sharing ? _sharinglistpost = list : _listpost = list;
      notifyListeners();
    }
  }

  Future<void> sharePost(String postid) async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/posts/$postid.json?auth=$token';
    try {
      final reponse = await http.get(url);
      final sharingurl =
          'https://moonlit-premise-234610.firebaseio.com/users/secretdata/usersshares/$userid/$postid.json?auth=$token';
      final sharingresponse = await http.put(sharingurl, body: reponse.body);
    } catch (error) {}
  }

  Future<void> getSharedposts() async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/usersshares/$userid.json?auth=$token';
    getPosts(sharing: true);
  }

  Future<void> deletepost(String postid) async {
    final allposturl =
        'https://moonlit-premise-234610.firebaseio.com/posts/$postid.json?auth=$token';
    final sharedpostsurl =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/usersshares/$userid/$postid.json?auth=$token';
    try {
      await http.delete(allposturl);
      await http.delete(sharedpostsurl);
    } catch (error) {
      print(error);
    }
    _listpost.removeWhere((post) {
      return post.id == postid;
    });
    _sharinglistpost.removeWhere((post) {
      return post.id == postid;
    });
    notifyListeners();
  }
}
