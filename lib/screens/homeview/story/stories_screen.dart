import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:provider/provider.dart';

class StoriesScreen extends StatelessWidget {
  final HomeViewProvider homeViewProvider;
  final int index;

  StoriesScreen(this.homeViewProvider, this.index);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return Scaffold(
      body: Container(
        width: devicesize.width,
        height: devicesize.height,
        child: CarouselSlider.builder(
            carouselController: homeViewProvider.getcontroller,
            itemCount: homeViewProvider.getstories.length,
            itemBuilder: (ctx, innerindex) {
              return Carousilitem(homeViewProvider, innerindex, devicesize);
            },
            options: CarouselOptions(
              initialPage: index,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(milliseconds: 300),
              height: devicesize.height,
              viewportFraction: 1.0,
            )),
      ),
    );
  }
}

class Carousilitem extends StatefulWidget {
  final HomeViewProvider homeViewProvider;
  final int innerindex;
  final Size devicesize;

  Carousilitem(this.homeViewProvider, this.innerindex, this.devicesize);

  @override
  _CarousilitemState createState() => _CarousilitemState();
}

class _CarousilitemState extends State<Carousilitem> {
  double currentopacty = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        width: widget.devicesize.width,
        height: widget.devicesize.height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (widget.homeViewProvider.getstories[widget.innerindex].image !=
                null)
              Image.network(
                widget.homeViewProvider.getstories[widget.innerindex].image,
                fit: BoxFit.fill,
              ),
            if (widget
                    .homeViewProvider.getstories[widget.innerindex].textStory !=
                null)
              Container(
                width: widget.devicesize.width,
                height: widget.devicesize.height - .14,
                color: widget.homeViewProvider.getstories[widget.innerindex]
                    .textStory.backgroundcolor,
                padding: EdgeInsets.all(30),
                child: Center(
                  child: AutoSizeText(
                    widget.homeViewProvider.getstories[widget.innerindex]
                        .textStory.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.7,
                      color: widget.homeViewProvider
                          .getstories[widget.innerindex].textStory.fontcolor,
                    ),
                    minFontSize: 30,
                  ),
                ),
              ),
            AnimatedOpacity(
              opacity: currentopacty,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOutQuad,
              child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.favorite,
                    size: 350,
                    color: Colors.red,
                  )),
            ),
            Container(
              width: widget.devicesize.width,
              height: widget.devicesize.height,
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(child: InkWell(
                    onTap: () {
                      widget.homeViewProvider.changestory('last');
                    },
                  ))),
                  Expanded(child: Container(
                    child: InkWell(
                      onTap: () {
                        widget.homeViewProvider.changestory('next');
                      },
                    ),
                  ))
                ],
              ),
            ),
            Positioned(
              top: 7,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                width: widget.devicesize.width,
                height: 10,
                child: LinearProgressIndicatorDemo(),
              ),
            ),
            Positioned(
              top: 20,
              left: 5,
              child: Container(
                width: widget.devicesize.width,
                height: widget.devicesize.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: widget.devicesize.width,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(widget
                              .homeViewProvider
                              .getstories[widget.innerindex]
                              .userdata
                              .profilepic),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget
                                  .homeViewProvider
                                  .getstories[widget.innerindex]
                                  .userdata
                                  .username,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' ${HelperMethod.getduration(widget.homeViewProvider.getstories[widget.innerindex].datetime)}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(17),
                                  color: Colors.white70),
                            )
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.power_input,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 4,
              child: Container(
                  width: widget.devicesize.width,
                  height: widget.devicesize.height * .1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.forward_5,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(6),
                            right: ScreenUtil().setWidth(6)),
                        width: widget.devicesize.width * .5,
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white)),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Reply to story',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(19))),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentopacty = 1;
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class LinearProgressIndicatorDemo extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LinearProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: animation.value,
      backgroundColor: Colors.white,
    );
  }
}
