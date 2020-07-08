import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/models/story.dart';
import 'package:flutterapp/providers/authontication/authontication_screen_provider.dart';
import 'package:flutterapp/providers/homeview_providers/story/createstory_provider.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:flutterapp/screens/authontication/authontication_screens.dart';
import 'package:flutterapp/screens/groupview/groupview_screen.dart';
import 'package:flutterapp/screens/homeview/homeview_screen.dart';
import 'package:flutterapp/screens/homeview/story/createstory_screen.dart';
import 'package:flutterapp/screens/profile/profilescreen.dart';
import 'package:flutterapp/screens/profile/profilescreendata.dart';
import 'package:flutterapp/widgets/createpost.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with TickerProviderStateMixin {
  bool home = false;
  bool notifications = false;
  AnimationController controller;
  AnimationController controllerb;
  AnimationController controllerc;
  AnimationController controllerd;
  AnimationController controllere;
  AnimationController controllerf;

  Animation<double> animation;
  Animation<double> animationb;
  Animation<double> animationc;
  Animation<double> animationd;
  Animation<double> animatione;
  Animation<double> animationf;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    controllerb = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    controllerc = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    controllerd = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    controllere = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    controllerf = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    animation = Tween<double>(begin: 0.0, end: 1).animate(controllerb);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    animationb = Tween<double>(begin: 0.0, end: 1).animate(controllerb);
    animationb.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllerb.forward();
      }
    });
    controllerb.forward();

    animationc = Tween<double>(begin: 0.0, end: 1).animate(controllerb);
    animationc.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllerc.forward();
      }
    });
    controllerc.forward();

    animationd = Tween<double>(begin: 0.0, end: 1).animate(controllerb);

    animationd.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllerd.forward();
      }
    });
    controllerd.forward();

    animatione = Tween<double>(begin: 0.0, end: 1).animate(controllerb);
    animatione.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllere.forward();
      }
    });
    controllere.forward();

    animationf = Tween<double>(begin: 0.0, end: 1).animate(controllerb);

    animationf.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllerf.forward();
      }
    });
    controllerf.forward();

    Tween<double>(begin: 0.0, end: 1).animate(controllerb);
    animatione.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllere.forward();
      }
    });
    controllere.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);
    final user = Provider.of<ProfileScreenProvider>(context);
    return home
        ? HomeView()
        : notifications
            ? GroupView()
            : Container(
                width: devicesize.width,
                height: double.infinity,
                padding: EdgeInsets.all(
                  ScreenUtil().setHeight(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ProfileScreenData()));
                      },
                      child: Container(
                        width: devicesize.width,
                        height: devicesize.height * .1,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: ScreenUtil().setHeight(24),
                            backgroundImage: NetworkImage(user.profilepic ==
                                    null
                                ? 'https://i0.wp.com/bsnl.ch/wp-content/uploads/2019/03/avatar-default-circle.png?fit=260%2C260&ssl=1'
                                : user.profilepic),
                          ),
                          title: Text(
                            user.username == null ? 'new user' : user.username,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ProfileScreenData()));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'View your profile',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(15),
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: ScreenUtil().setWidth(30),
                                  mainAxisSpacing: ScreenUtil().setHeight(30),
                                  childAspectRatio: 3 / 2),
                          children: <Widget>[
                            SettingItem('Home', Icons.home, () {
                              setState(() {
                                home = true;
                              });
                            }),
                            FadeTransition(
                                opacity: controllerb,
                                child: SettingItem(
                                    'Profile', Icons.person_outline, () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ProfileScreenData()));
                                })),
                            FadeTransition(
                                opacity: controllerc,
                                child: SettingItem(
                                    'Create Story', Icons.camera_alt, () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ChangeNotifierProvider(
                                          create: (ctx) => CreatStoryProvider(),
                                          child: CreateStoryScreen())));
                                })),
                            FadeTransition(
                                opacity: controllerd,
                                child:
                                    SettingItem('Group View', Icons.group, () {
                                  setState(() {
                                    notifications = true;
                                  });
                                })),
                            FadeTransition(
                                opacity: controllere,
                                child:
                                    SettingItem('Edit profile', Icons.edit, () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ProfileScreen()));
                                })),
                            FadeTransition(
                                opacity: controllerf,
                                child: SettingItem(
                                    'Log out', Icons.call_missed_outgoing,
                                    () async {
                                  await Provider.of<
                                              AuthonticationScreenProvider>(
                                          context,
                                          listen: false)
                                      .logout();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              AuthonticationScreen()));
                                })),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}

class SettingItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;

  SettingItem(this.text, this.icon, this.function);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18))),
      elevation: 5,
      child: Center(
        child: FlatButton.icon(
            onPressed: () {
              function();
            },
            icon: Icon(
              icon,
              color: Colors.blueAccent,
              size: ScreenUtil().setHeight(25),
            ),
            label: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(
                    18,
                  ),
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
