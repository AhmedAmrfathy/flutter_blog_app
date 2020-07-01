import 'package:flutter/material.dart';
import 'package:flutterapp/models/postcomment.dart';
import 'package:flutterapp/providers/authontication_screen_provider.dart';
import 'package:flutterapp/providers/groupview/groupview_provider.dart';
import 'package:flutterapp/providers/home_provider.dart';
import 'package:flutterapp/providers/homeview_providers/homeview_provider.dart';
import 'package:flutterapp/providers/homeview_providers/posts/commentsheet.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:flutterapp/screens/authontication_screens.dart';
import 'package:flutterapp/screens/homeview/home_sreen.dart';
import 'package:flutterapp/screens/homeview/homeview_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthonticationScreenProvider()),
        ChangeNotifierProxyProvider<AuthonticationScreenProvider,
            HomeViewProvider>(
          update: (ctx, authdata, previousdata) => HomeViewProvider(
              authdata.userid,
              authdata.token,
              authdata.userprofileimage,
              authdata.username,
              previousdata == null ? [] : previousdata.getposts??[],
              previousdata == null ? [] : previousdata.getstories??[]),
        ),
        ChangeNotifierProxyProvider<AuthonticationScreenProvider,
            ProfileScreenProvider>(
          update: (ctx, authdata, previousdata) => ProfileScreenProvider(
              id: authdata.userid,
              token: authdata.token,
              username: authdata.username,
              profilepic: authdata.userprofileimage),
        ),
        // ChangeNotifierProvider.value(value: HomeViewProvider()),
        ChangeNotifierProvider.value(value: GroupViewProvider()),
        ChangeNotifierProvider.value(value: HomeProvider()),
        ChangeNotifierProvider.value(value: CommentSheet())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: AuthonticationScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          HomeScreen.routeforhomescree: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
