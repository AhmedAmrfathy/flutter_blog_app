import 'package:flutter/material.dart';
import 'package:flutterapp/providers/home_provider.dart';
import 'package:flutterapp/screens/groupview/groupview_screen.dart';
import 'package:flutterapp/screens/homeview/homeview_screen.dart';
import 'package:flutterapp/screens/tryingscreen.dart';
import 'package:flutterapp/screens/vedioview_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeforhomescree = 'homerout';



  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    Provider.of<HomeProvider>(context,listen: false).editcontext(context);
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'friendbook',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(51, 51, 255, .8)),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.search,
                  size: 28,
                  color: Colors.black,
                )),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.message,
                  size: 28,
                  color: Colors.black,
                ))
          ],
          bottom: TabBar(
            indicatorColor: Colors.blueAccent,
            tabs: <Widget>[
              Tab(
                  icon: Icon(
                Icons.home,
                color: Colors.grey,
                size: 30,
              )),
              Tab(
                  icon: Icon(
                Icons.group,
                color: Colors.grey,
                size: 30,
              )),
              Tab(
                  icon: Icon(
                Icons.video_library,
                color: Colors.grey,
                size: 30,
              )),
              Tab(
                  icon: Icon(
                Icons.card_giftcard,
                color: Colors.grey,
                size: 30,
              )),
              Tab(
                  icon: Icon(
                Icons.notifications_none,
                color: Colors.grey,
                size: 30,
              )),
              Tab(
                  icon: Icon(
                Icons.storage,
                color: Colors.grey,
                size: 30,
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 16), child: HomeView()),
            GroupView(),
            VedioViewScreen(),
            GroupView(),
            GroupView(),
            TryingScreen(),
          ],
        ),

      ),
    );
  }
}
