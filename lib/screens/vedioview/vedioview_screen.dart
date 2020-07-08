import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/widgets/post/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VedioViewScreen extends StatelessWidget {
  final VideoPlayerController videoPlayerControllerr =
      VideoPlayerController.network('');

  Widget circleicon(IconData iconData) {
    return Container(
      width: ScreenUtil().setWidth(35),
      height: ScreenUtil().setHeight(35),
      margin: EdgeInsets.only(right: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Color.fromRGBO(200, 200, 200, 1)),
      child: Center(
        child: Icon(
          iconData,
          size: ScreenUtil().setHeight(30),
        ),
      ),
    );
  }

  Widget chanelswidget(
    Size devicesize,
  ) {
    return Container(
      width: ScreenUtil().setWidth(92),
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.only(top: 8),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: chanelitem(
                'https://www.klma.org/wp-content/uploads/2019/05/mbc-masr.jpg'),
          ),
          Positioned(
            left: 25,
            child: chanelitem(
                'https://yt3.ggpht.com/a/AATXAJwot2rw2r9w-LrtqO-K3102xkCuW4qKqMdVAQ=s900-c-k-c0xffffffff-no-rj-mo'),
          ),
          Positioned(
            left: 50,
            child: chanelitem(
                'https://ksh5h.net/wp-content/uploads/2019/11/3023.jpg'),
          )
        ],
      ),
    );
  }

  Widget chanelitem(String imge) {
    return Container(
      width: ScreenUtil().setWidth(33),
      height: ScreenUtil().setHeight(33),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          imge,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget postswidget() {
    return Consumer<HomeViewProvider>(
        builder: (ctx, object, child) => FutureBuilder(
              future: object.initiatevedio(),
              builder: (ctx, snapshotdata) {
                if (snapshotdata.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => PostWidget(),
//                        circlephoto: object.getvediospost[index].circlephoto,
//                        personname: object.getvediospost[index].personname,
//                        posttime: object.getvediospost[index].posttime,
//                        numberofcomment:
//                            object.getvediospost[index].numberofcomment,
//                        posttext: object.getvediospost[index].posttext,
//                        postvedio: object.getvediospost[index].postvedio,
//                        videoPlayerController: object.listofcontroller[index]),
                    itemCount: object.getvediospost.length,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    return ListView(
      children: <Widget>[
        Container(
          width: devicesize.width,
          height: devicesize.height * .17,
          padding: EdgeInsets.only(left: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Watch',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 28),
                        ),
                        Spacer(),
                        circleicon(Icons.search),
                        circleicon(Icons.person)
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Your Watchlist',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                    Spacer(),
                    chanelswidget(devicesize)
                  ],
                ),
              )
            ],
          ),
        ),
        postswidget()
      ],
    );
  }
}
