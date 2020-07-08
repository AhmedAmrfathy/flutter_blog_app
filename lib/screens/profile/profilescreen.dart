import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Country> countries = [
    Country(
        countryname: 'Egypt',
        Countryflag:
            'https://alamphoto.com/wp-content/uploads/2017/08/Egypt%20Flag%20Photos%20(5)-388x276.jpg'),
    Country(
      countryname: 'Tunisia',
      Countryflag:
          'https://www.mah6at.net/wp-content/uploads/2019/05/1280px-Flag_of_Tunisia.svg_-300x200.png',
    ),
    Country(
      countryname: 'Moroco',
      Countryflag:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTllI3nZwROjRkD6VYi06sD-k7N98VrkezriQ&usqp=CAU',
    ),
    Country(
      countryname: 'England',
      Countryflag:
          'https://m.marefa.org/images/thumb/6/6a/Union_Flag_%28including_Wales%29.svg/300px-Union_Flag_%28including_Wales%29.svg.png',
    ),
    Country(
      countryname: 'Brazil',
      Countryflag:
          'https://besthqwallpapers.com/Uploads/11-7-2017/16359/thumb2-brazilian-flag-brazil-flag-of-brazil-silk-fabric.jpg',
    ),
  ];
  int radiostatusvalue = 1;
  bool showcountrylist = false;
  String defaultcountry = 'Country';
  String defaultflag =
      'https://e7.pngegg.com/pngimages/60/503/png-clipart-world-global-network-computer-network-global-miscellaneous-globe.png';


  @override
  Widget build(BuildContext context) {
    final profiledata = Provider.of<ProfileScreenProvider>(context);
    final devicesize = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: devicesize.width,
        height: devicesize.height,
        allowFontScaling: false);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: devicesize.width,
          height: devicesize.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blueAccent,
            Color.fromRGBO(102, 178, 255, .8)
          ], begin: Alignment.bottomLeft, end: Alignment.bottomRight)),
          child: Stack(
            children: <Widget>[
              Container(
                width: devicesize.width,
                height: devicesize.height * .4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(devicesize.width, 126),
                        bottomRight: Radius.elliptical(devicesize.width, 126))),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(onTap: (){
                        profiledata.getImage();
                      },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 4,
                              )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: profiledata.image == null
                                ? Image.network(
                                    'https://www.aljadeed.com/wp-content/plugins/all-in-one-seo-pack-pro/images/default-user-image.png',
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    profiledata.image,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(18),
                      ),
                      Text(
                        'Ahmed Amr',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(4),
                      ),
                      Text(
                        'Engineer',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenUtil().setSp(17)),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: devicesize.height * .4,
                child: Container(
                  width: devicesize.width,
                  height: devicesize.height * .6,
                  padding: EdgeInsets.only(top: 20, right: 15, left: 15),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: TextField(
                              controller: profiledata.usernamecontroller,
                              decoration: InputDecoration(
                                hintText: 'Name',
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              child: TextField(
                            controller: profiledata.jobcontroller,
                            decoration: InputDecoration(
                              hintText: 'Job',
                            ),
                            maxLines: 1,
                          )),
                        ),
                        Expanded(
                          flex: showcountrylist ? 2 : 1,
                          child: showcountrylist
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) => Container(
                                    margin: EdgeInsets.only(top: 3),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          defaultcountry =
                                              countries[index].countryname;
                                          defaultflag =
                                              countries[index].Countryflag;
                                          showcountrylist = false;

                                        });
                                        profiledata.countrycontroller.text=defaultcountry;
                                      },
                                      child: SizedBox(
                                        width: devicesize.width,
                                        height: 36,
                                        child: ListTile(
                                          leading: Text(
                                              countries[index].countryname),
                                          trailing: SizedBox(
                                            width: ScreenUtil().setWidth(30),
                                            height: ScreenUtil().setHeight(30),
                                            child: Image.network(
                                                countries[index].Countryflag),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemCount: countries.length,
                                )
                              : Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextField(
                                          onTap: () {
                                            setState(() {
                                              showcountrylist = true;
                                            });
                                          },
                                          controller:
                                              profiledata.countrycontroller,
                                          decoration: InputDecoration(
                                              hintText: defaultcountry,
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),border: InputBorder.none),
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(30),
                                        height: ScreenUtil().setHeight(30),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            defaultflag,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'State',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(18)),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(5),
                              ),
                              Radio(
                                groupValue: radiostatusvalue,
                                value: 1,
                                onChanged: (v) {
                                  setState(() {
                                    radiostatusvalue = v;
                                    profiledata.status='Single';
                                  });
                                },
                              ),
                              Text(
                                'Single',
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(16)),
                              ),
                              Radio(
                                groupValue: radiostatusvalue,
                                value: 2,
                                onChanged: (v) {
                                  setState(() {
                                    radiostatusvalue = v;
                                    profiledata.status='Enganged';

                                  });
                                },
                              ),
                              Text('enganed',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16))),
                              Radio(
                                groupValue: radiostatusvalue,
                                value: 3,
                                onChanged: (v) {
                                  setState(() {
                                    radiostatusvalue = v;
                                    profiledata.status='Maarried';

                                  });
                                },
                              ),
                              Text('Married',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16))),

                            ],
                          ),
                        ),
                        Expanded(flex: 2,
                            child: Align(alignment: Alignment.center,
                              child: Container(
                                width: 100,
                                height: 50,
                                padding: EdgeInsets.only(bottom: 10),
                                child: profiledata.isloading
                                    ? CircularProgressIndicator(
                                  strokeWidth: 5,
                                )
                                    : FloatingActionButton(
                                  onPressed: () async {
                                    profiledata.changestatus();
                                    await profiledata.uploadImage();
                                    try {
                                      await profiledata.savedata(
                                              );
                                      Navigator.of(context).pop();
                                      profiledata.changestatus();
                                    } catch (error) {
                                      await HelperMethod
                                          .showerrordialog(
                                          'sorry an error occurd',
                                          context);
                                      Navigator.of(context).pop();
                                      profiledata.changestatus();
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12)),
                                  child: Text('Save data'),
                                ),
                              ),
                            ),
                          ),


                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}

class Country {
  final String countryname;
  final String Countryflag;

  Country({this.countryname, this.Countryflag});
}
