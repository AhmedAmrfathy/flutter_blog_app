import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthonticationScreenProvider with ChangeNotifier {
  String _token;
  String _userid;
  DateTime _expiredata;
  String _username;
  String _userprofileimage;

 var isloading=false;

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
      print(data);
      _token = data['idToken'];
      _userid = data['localId'];
      _expiredata =
          DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
      try{
        final url='https://moonlit-premise-234610.firebaseio.com/users/secretdata/$_userid.json?auth=$token';
        final response=await http.get(url);
        final data=json.decode(response.body)as Map<String,dynamic>;
        print(data);
        data.forEach((key,value){
         if(key=='imgurl'){
           _userprofileimage=value;
         }
         else if(key=='name'){
           _username=value;
         }

        });

      }catch(error){
        print(error);
      }
      notifyListeners();
    } catch (error) {
      print(error) ;
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
