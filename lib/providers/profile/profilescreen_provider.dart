import 'dart:io';
import 'dart:convert';
import 'package:flutterapp/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ProfileScreenProvider with ChangeNotifier {
  String id;
  String token;
  String username;
  String profilepic;

  ProfileScreenProvider({this.id, this.token, this.username, this.profilepic});


  String profileimage;
  TextEditingController textEditingController = new TextEditingController();

  File image;
  final picker = ImagePicker();
  var isloading = false;

  get ifisloading {
    return isloading;
  }

  changestatus() {
    isloading = !isloading;
    notifyListeners();
  }

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (image != null) {
      notifyListeners();
      StorageReference firebasestorageref =
          FirebaseStorage.instance.ref().child('Usersimages').child('$id.jpg');
      final StorageUploadTask task = firebasestorageref.putFile(image);
      var downloadurl = await (await task.onComplete).ref.getDownloadURL();
      profileimage = downloadurl;
      profilepic = downloadurl;
    }
  }

  Future<void> savedata(String name) async {
    isloading = true;
    notifyListeners();
    String url =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$id.json?auth=$token';
    try {
      final response = await http.put(url,
          body: json.encode({'imgurl': profileimage, 'name': name}));
      username=name;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }


}
