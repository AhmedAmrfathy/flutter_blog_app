import 'package:flutter/cupertino.dart';
import 'package:flutterapp/exception/myexception.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthonticationScreenProvider with ChangeNotifier {
  String _token;
  String _userid;
  DateTime _expiredata;
  String _username;
  String _userprofileimage;
  String _userstatus;
  String _usercountry;
  String _userjob;

  String get userstatus => _userstatus;

  String get usercountry => _usercountry;

  String get userjob => _userjob;
  var isloading = false;

  String get token {
    return _token;
  }

  String get userid {
    return _userid;
  }

  String get username {
    return _username;
  }

  String get userprofileimage {
    return _userprofileimage;
  }

  bool get isauth {
    return _token != null;
  }

  void toogleCheck() {
    isloading = !isloading;
    notifyListeners();
  }

  Future<void> authonticate(
      String email, String password, String dynamicword) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$dynamicword?key=AIzaSyD7nUvL8hnXnyJt43_UeJ_BOcRJTS4FTgo";
    try {
      final respone = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final data = json.decode(respone.body);
      if (data['error'] != null) {
        throw myException(data['error']['message']);
      }
      print(data);
      _token = data['idToken'];
      _userid = data['localId'];
      _expiredata =
          DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', data['idToken']);
      pref.setString('id', data['localId']);
      pref.setString(
          'expiresdata',
          DateTime.now()
              .add(Duration(seconds: int.parse(data['expiresIn'])))
              .toString());
      if (data['idToken'] != null) {
        pref.setBool('isauth', true);
      } else {
        pref.setBool('isauth', false);
      }

      try {
        final url =
            'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$_userid.json?auth=$token';
        final response = await http.get(url);
        final data = json.decode(response.body) as Map<String, dynamic>;
        print(data);
        data.forEach((key, value) {
          if (key == 'imgurl') {
            _userprofileimage = value;
          } else if (key == 'name') {
            _username = value;
          } else if (key == 'job') {
            _userjob = value;
          } else if (key == 'staus') {
            _userstatus = value;
          } else if (key == 'country') {
            _usercountry = value;
          }
        });
      } catch (error) {
        print(error);
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
   tryautologin()async{
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
      _token= prefs.getString('token');
      _userid= prefs.getString('id');
    try {
      final url =
          'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$_userid.json?auth=$token';
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      data.forEach((key, value) {
        if (key == 'imgurl') {
          _userprofileimage = value;
        } else if (key == 'name') {
          _username = value;
        } else if (key == 'job') {
          _userjob = value;
        } else if (key == 'staus') {
          _userstatus = value;
        } else if (key == 'country') {
          _usercountry = value;
        }
      });
    } catch (error) {
      print(error);
    }
      notifyListeners();
      print(_token);

  }

  var loginscreen = true;

  bool inloginscreen() {
    return loginscreen;
  }

  onchangeauthonticationmode() {
    loginscreen = !loginscreen;
    print(loginscreen);
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isauth', false);
  }
}
