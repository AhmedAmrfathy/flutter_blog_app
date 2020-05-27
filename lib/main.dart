import 'package:flutter/material.dart';
import 'package:flutterapp/providers/authontication_screen_provider.dart';
import 'package:flutterapp/providers/groupview_provider.dart';
import 'package:flutterapp/providers/homeview_provider.dart';
import 'package:flutterapp/screens/authontication_screens.dart';
import 'package:flutterapp/screens/home_sreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthonticationScreenProvider()),
        ChangeNotifierProvider.value(value: HomeViewProvider()),
        ChangeNotifierProvider.value(value: GroupViewProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: AuthonticationScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          HomeScreen.routeforhomescree:(ctx)=>HomeScreen(),
        },
      ),
    );
  }
}



