import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthonticationScreenProvider with ChangeNotifier {
  String _token;
  String _userid;
  DateTime _expiredata;
 var isloading=false;
 void toogleCheck(){
   isloading=!isloading;
   notifyListeners();
 }
  Future<void> authonticate(String email, String password,String dynamicword) async {
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
      _token = data['idToken'];
      _userid = data['localId'];
      _expiredata =
          DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
      notifyListeners();
    } catch (error) {
      return error;
    }
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
}
