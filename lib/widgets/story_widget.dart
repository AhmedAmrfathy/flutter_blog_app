import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/story.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';

class StoryWidget extends StatelessWidget {
  final String photo;
  final TextStory textstory;
  final ProfileScreenProvider userdata;
  final int index;

  StoryWidget(this.photo, this.textstory, this.userdata, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 6),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (photo != null)
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                photo,
                fit: BoxFit.fill,
              ),
            ),
          if (textstory != null)
            Container(
              padding: EdgeInsets.only(top: 35, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Color(textstory.backgroundcolor.value),
                  borderRadius: BorderRadius.circular(10)),
              child: AutoSizeText(
                textstory.text,
                style: TextStyle(
                    color: Color(textstory.fontcolor.value), height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(userdata.profilepic),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 3,
            child: Text(
              index == 0 ? 'Add to your Story' : userdata.username,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
