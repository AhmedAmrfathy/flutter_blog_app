import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/models/story.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/providers/homeview_providers/story/createstory_provider.dart';

class CreateStoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CreatStoryProvider>(context);
    final profiledata =
        Provider.of<ProfileScreenProvider>(context, listen: false);
    final homeview = Provider.of<HomeViewProvider>(context, listen: false);
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return Scaffold(
        body: Container(
      width: devicesize.width,
      height: devicesize.height,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: ScreenUtil().setHeight(7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: devicesize.height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: ScreenUtil().setHeight(20),
                  ),
                ),
                Text(
                  'Create Story',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                IconButton(
                  onPressed: ()async {
                    await state.uploadImage();
                    Story story;
                    if(state.image!=null){
                      story = Story(profiledata.id, profiledata,
                          image: state.imageurl);
                    }else{
                      story= Story(profiledata.id, profiledata,
                          textStory: TextStory(
                              text: state.textEditingController.text,
                              fontcolor: state.storyfontcolor,
                              backgroundcolor: state.storycolor),);
                    }
                   await homeview.addStory(story);
                    state.removeimg();
                   Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.send,
                    color: state.image != null
                        ? Colors.blue
                        : state.textEditingController.text == ''
                            ? Colors.blueGrey
                            : Colors.blue,
                    size: ScreenUtil().setHeight(24),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: devicesize.height * .24,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 5),
              children: <Widget>[
                StoryChoice(
                    devicesize,
                    Color.fromRGBO(102, 0, 204, 1),
                    Color.fromRGBO(255, 102, 178, 1),
                    Icons.text_format,
                    'Text', () {
                  state.changeChoice('text');
                }),
                StoryChoice(
                    devicesize,
                    Color.fromRGBO(0, 204, 102, 1),
                    Color.fromRGBO(51, 153, 255, 1),
                    Icons.music_note,
                    'Music', () {
                  state.changeChoice('text');
                }),
                StoryChoice(
                    devicesize,
                    Color.fromRGBO(255, 128, 0, 1),
                    Color.fromRGBO(255, 178, 102, 1),
                    Icons.photo_library,
                    'gallery', () {
                  state.changeChoice('image');
                }),
                StoryChoice(
                    devicesize,
                    Color.fromRGBO(255, 102, 102, 1),
                    Color.fromRGBO(255, 178, 102, 1),
                    Icons.tag_faces,
                    'Selfie', () {
                  state.changeChoice('text');
                }),
                StoryChoice(
                    devicesize,
                    Color.fromRGBO(102, 0, 204, 1),
                    Color.fromRGBO(255, 102, 178, 1),
                    Icons.rate_review,
                    'Poll', () {
                  state.changeChoice('text');
                }),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 400,
                  height: 300,
                  margin:
                      EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(10),
                      left: ScreenUtil().setHeight(10),
                      right: ScreenUtil().setHeight(10)),
                  decoration: state.choice == 'text'
                      ? BoxDecoration(
                          color: state.storycolor,
                          border: Border.all(color: Colors.black54))
                      : BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                  child: state.choice == 'text'
                      ? Center(
                          child: TextField(
                            onChanged: (change) {
                              state.setstate();
                            },
                            controller: state.textEditingController,
                            decoration: InputDecoration(
                                hintText: 'TXt',
                                hintStyle: TextStyle(fontSize: 50)),
                            style: TextStyle(
                              height: 1.7,
                              textBaseline: TextBaseline.alphabetic,
                              color: state.storyfontcolor,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 15,
                          ),
                        )
                      : state.image != null
                          ? Container(
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(15)),
                                    child: Image.file(
                                      state.image,
                                      fit: BoxFit.fill,
                                      width: devicesize.width - 200,
                                      height: devicesize.height - 300,
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: ScreenUtil().setHeight(30),
                                      ),
                                      onPressed: () {
                                        state.removeimg();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                await state.getimage('img');
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: ScreenUtil().setWidth(100),
                                  height: ScreenUtil().setHeight(100),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'https://cdn0.iconfinder.com/data/icons/set-app-incredibles/24/Image-01-512.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ),
                if (state.choice == 'text')
                  Container(
                    width: devicesize.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.format_color_fill,
                            color: state.storycolor,
                            size: 30,
                          ),
                        ),
                        ColorWidet(HelperMethod.red, () {
                          state.changeColorStory(HelperMethod.red);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.blue, () {
                          state.changeColorStory(HelperMethod.blue);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.lightgreen, () {
                          state.changeColorStory(HelperMethod.lightgreen);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.yellow, () {
                          state.changeColorStory(HelperMethod.yellow);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.white, () {
                          state.changeColorStory(HelperMethod.white);
                          ;
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.lightgrey, () {
                          state.changeColorStory(HelperMethod.lightgrey);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.black, () {
                          state.changeColorStory(HelperMethod.black);
                        }),
                      ],
                    ),
                  ),
                if (state.choice == 'text')
                  Container(
                    width: devicesize.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.colorize,
                            color: state.storyfontcolor,
                            size: 30,
                          ),
                        ),
                        ColorWidet(HelperMethod.red, () {
                          state.changeStoryFontColor(HelperMethod.red);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.blue, () {
                          state.changeStoryFontColor(HelperMethod.blue);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.lightgreen, () {
                          state.changeStoryFontColor(HelperMethod.lightgreen);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.yellow, () {
                          state.changeStoryFontColor(HelperMethod.yellow);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.white, () {
                          state.changeStoryFontColor(HelperMethod.white);
                          ;
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.lightgrey, () {
                          state.changeStoryFontColor(HelperMethod.lightgrey);
                        }),
                        SizedBox(
                          width: 4,
                        ),
                        ColorWidet(HelperMethod.black, () {
                          state.changeStoryFontColor(HelperMethod.black);
                        }),
                      ],
                    ),
                  ),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}

class StoryChoice extends StatelessWidget {
  final Size devicesize;
  final Color start;
  final Color end;
  final IconData icon;
  final String word;
  final Function changechoice;

  StoryChoice(this.devicesize, this.start, this.end, this.icon, this.word,
      this.changechoice);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changechoice();
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 9),
        //  height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [start, end],
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 55,
              height: 55,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                icon,
                color: Colors.black54,
              ),
            ),
            Positioned(
              bottom: 27,
              child: Text(
                word,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorWidet extends StatelessWidget {
  final Color color;
  final Function changecolor;

  ColorWidet(this.color, this.changecolor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changecolor();
      },
      child: Container(
        width: ScreenUtil().setWidth(35),
        height: ScreenUtil().setHeight(35),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
