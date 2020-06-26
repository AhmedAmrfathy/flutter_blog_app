import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class CommentSheet with ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();
  String commentimage;
  String Userid;
  String postid;
  String token;
  File image;
  final picker = ImagePicker();
  Function imagestate;
  Function liststate;

  Future getImage(String useridd, String postidd,String tokenn) async {
    Userid = useridd;
    postid = postidd;
    token=tokenn;
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (image != null) {
      notifyListeners();
      StorageReference firebasestorageref = FirebaseStorage.instance
          .ref()
          .child('Commentsimage')
          .child('$postid')
          .child('$Userid');
      final StorageUploadTask task = firebasestorageref.putFile(image);
      var downloadurl = await (await task.onComplete).ref.getDownloadURL();
      commentimage = downloadurl;
    }
  }

  Future<void> savedata(String name) async {
    notifyListeners();
    String url =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$Userid.json?auth=$token';
    try {
      final response = await http.post(url,
          body: json.encode({'imgurl': commentimage, 'name': name}));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
