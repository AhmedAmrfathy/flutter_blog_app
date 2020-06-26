import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';

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
              return Carousilitem(
                  homeViewProvider, index, innerindex, devicesize);
            },
            options: CarouselOptions(
                initialPage: index,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(milliseconds: 300),
                height: devicesize.height,
                viewportFraction: 1.0)),
      ),
    );
  }
}

class Carousilitem extends StatelessWidget {
  final HomeViewProvider homeViewProvider;
  final int index;
  final int innerindex;
  final Size devicesize;

  Carousilitem(
      this.homeViewProvider, this.index, this.innerindex, this.devicesize);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        width: devicesize.width,
        height: devicesize.height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              homeViewProvider.getstories[innerindex].photo,
              fit: BoxFit.fill,
            ),
            Container(
              width: devicesize.width,
              height: devicesize.height,
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(child: InkWell(
                    onTap: () {
                      homeViewProvider.changestory('last');
                    },
                  ))),
                  Expanded(child: Container(
                    child: InkWell(
                      onTap: () {
                        homeViewProvider.changestory('next');
                      },
                    ),
                  ))
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 5,
              child: Container(
                width: devicesize.width,
                height: devicesize.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: devicesize.width,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(
                              'https://imagess.cc/wp-content/uploads/2018/05/5843.jpg'),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Amira carazon',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' 1h',
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
                  width: devicesize.width,
                  height: devicesize.height * .1,
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
                        width: devicesize.width * .5,
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
