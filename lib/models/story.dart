import 'package:flutter/cupertino.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';

class Story with ChangeNotifier {
  final String id;
  final TextStory textStory;
  final String image;
  final ProfileScreenProvider userdata;
  final String datetime;

  Story(this.id,this.userdata, {this.textStory, this.image,this.datetime});
}

class TextStory {
  final String text;
  final Color fontcolor;
  final Color backgroundcolor;

  TextStory({this.text, this.fontcolor, this.backgroundcolor});
}
