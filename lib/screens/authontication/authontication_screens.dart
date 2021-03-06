import 'package:flutter/material.dart';
import 'package:flutterapp/providers/authontication/authontication_screen_provider.dart';
import 'package:flutterapp/screens/homeview/home_sreen.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/exception/myexception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthonticationScreen extends StatefulWidget {
  @override
  _AuthonticationScreenState createState() => _AuthonticationScreenState();
}

class _AuthonticationScreenState extends State<AuthonticationScreen> {
  @override
  void initState() {
  checkauth();
    super.initState();
  }
 Future checkauth()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isauth')) {
      await Provider.of<AuthonticationScreenProvider>(context,listen: false).tryautologin();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  var logindata = {'email': '', 'password': ''};
  var registerdata = {
    'email': '',
    'password': '',
    'confirmpassword': '',
    'country': '',
    'phone': '',
  };

  void showerrordialog(String massage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('sorry an error occured'),
              content: Text(massage),
              actions: <Widget>[
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Future<void> submit(String formtype) async {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
      Provider.of<AuthonticationScreenProvider>(context, listen: false)
          .toogleCheck();
      try {
        if (formtype == 'login') {
          await Provider.of<AuthonticationScreenProvider>(context,
                  listen: false)
              .authonticate(logindata['email'], logindata['password'],
                  'signInWithPassword');
          Provider.of<AuthonticationScreenProvider>(context, listen: false)
              .toogleCheck();
        } else {
          await Provider.of<AuthonticationScreenProvider>(context,
                  listen: false)
              .authonticate(
                  registerdata['email'], registerdata['password'], 'signUp');
          Provider.of<AuthonticationScreenProvider>(context, listen: false)
              .toogleCheck();
        }
        Navigator.pushReplacementNamed(context, HomeScreen.routeforhomescree);
      } on myException catch (myexceptionerrorerror) {
        var errormesssage = 'failed autontication';
        if (myexceptionerrorerror.messege.contains('EMAIL_EXISTS')) {
          errormesssage = 'sorry this email is already exists';
        } else if (myexceptionerrorerror.messege.contains('INVALID_EMAIL')) {
          errormesssage = 'this is not valid email address';
        } else if (myexceptionerrorerror.messege.contains('WEAK_PASSWORD')) {
          errormesssage = 'this is too short password ';
        } else if (myexceptionerrorerror.messege.contains('EMAIL_NOT_FOUND')) {
          errormesssage = 'sorry this email not found';
        } else if (myexceptionerrorerror.messege.contains('INVALID_PASSWORD')) {
          errormesssage = 'this invalid password';
        }
        showerrordialog(errormesssage);
        Provider.of<AuthonticationScreenProvider>(context, listen: false)
            .toogleCheck();
      } catch (generalerror) {
        var err = 'sorry we cant authontocate you now please try again later';
        showerrordialog(err);
        Provider.of<AuthonticationScreenProvider>(context, listen: false)
            .toogleCheck();
      }
    }
  }

  Widget toolbarwidget(Size devicesize, AuthonticationScreenProvider provider) {
    return Container(
      width: devicesize.width,
      height: provider.inloginscreen()
          ? devicesize.height * .3
          : devicesize.height * .2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(0, 102, 204, 1),
                Color.fromRGBO(51, 153, 255, 1)
              ]),
          borderRadius: provider.inloginscreen()
              ? BorderRadius.only(bottomRight: Radius.circular(185))
              : BorderRadius.only(
                  bottomLeft: Radius.elliptical(devicesize.width, 80),
                  bottomRight: Radius.elliptical(devicesize.width, 80))),
      child: Align(
        alignment:
            provider.inloginscreen() ? Alignment(-.7, 0) : Alignment(0, 0),
        child: Text(provider.inloginscreen() ? '  friendbook' : 'Sign Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget formwidget(Size devicesize, AuthonticationScreenProvider provider) {
    return Container(
      width: devicesize.width,
      height: provider.inloginscreen()
          ? devicesize.height * .5
          : devicesize.height * .8,
      padding: EdgeInsets.all(20),
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: const Color.fromRGBO(153, 255, 255, 1))),
          child: form(provider)),
    );
  }

  Widget form(AuthonticationScreenProvider provider) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              formelemnt('Email', Icons.account_circle, provider),
              Divider(
                color: Colors.blue,
              ),
              formelemnt('Password', Icons.lock, provider),
              Divider(
                color: Colors.blue,
              ),
              if (!provider.inloginscreen())
                Column(
                  children: <Widget>[
                    formelemnt('confirm Password', Icons.lock, provider),
                    Divider(),
                    formelemnt('Phone', Icons.phone, provider),
                    Divider(),
                    formelemnt('Country', Icons.account_balance, provider),
                    Divider()
                  ],
                ),
              provider.isloading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: () => provider.inloginscreen()
                          ? submit('login')
                          : submit('signup'),
                      child: Text(
                        'ok',
                        style: TextStyle(fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.blue),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: InkWell(
                  onTap: () => provider.onchangeauthonticationmode(),
                  child: provider.inloginscreen()
                      ? Text(
                          'I don`t have an account yet',
                          style:
                              TextStyle(fontSize: 14, color: Colors.lightBlue),
                        )
                      : Container(
                          child: Text('Log in'),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formelemnt(
      String hinttext, IconData icon, AuthonticationScreenProvider provider) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 29),
          Container(
            width: 270,
            height: 40,
            //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            margin: EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                obscureText:
                    hinttext == 'Password' || hinttext == 'confirm Password'
                        ? true
                        : false,
                decoration: InputDecoration(
                    hintText: hinttext,
                    hintStyle: TextStyle(fontSize: 20),
                    border: InputBorder.none),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter your $hinttext ';
                  }
                  if (hinttext == 'Email') {
                    if (!value.contains('@')) {
                      return 'this is invalid email ';
                    }
                    if (value.length < 10) {
                      return 'invalid email address';
                    }
                  }
                  if (hinttext == 'Password' ||
                      hinttext == 'confirm Password') {
                    if (value.length < 10) {
                      return 'too short password';
                    }
                  }
                  if (hinttext == 'Phone') {
                    if (value.length < 11) {
                      return 'unavailable phone number';
                    }
                  }
                },
                onSaved: (value) {
                  if (provider.inloginscreen()) {
                    if (hinttext == 'Email') {
                      logindata['email'] = value;
                    }
                    if (hinttext == 'Password') {
                      logindata['password'] = value;
                    }
                  } else {
                    if (hinttext == 'Email') {
                      registerdata['email'] = value;
                    }
                    if (hinttext == 'Password') {
                      registerdata['password'] = value;
                    }
                    if (hinttext == 'confirmPassword') {
                      registerdata['confirmpassword'] = value;
                    }
                    if (hinttext == 'Phone') {
                      registerdata['phone'] = value;
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authprovider = Provider.of<AuthonticationScreenProvider>(context);
    return Scaffold(
      body: Container(
        width: devicesize.width,
        height: devicesize.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              toolbarwidget(devicesize, authprovider),
              formwidget(devicesize, authprovider)
            ],
          ),
        ),
      ),
    );
  }
}
