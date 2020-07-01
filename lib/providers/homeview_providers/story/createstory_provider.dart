import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:random_string/random_string.dart';

class CreatStoryProvider with ChangeNotifier {
  // this is first choice of the story [ text story  ]
  String _choice = 'text';
  Color _storycolor = HelperMethod.blue;
  Color _storyfontcolor = HelperMethod.black;
  TextEditingController textEditingController = TextEditingController();

  String get choice => _choice;

  Color get storycolor => _storycolor;

  Color get storyfontcolor => _storyfontcolor;

  changeStoryFontColor(Color color) {
    _storyfontcolor = color;
    notifyListeners();
  }

  changeColorStory(Color color) {
    _storycolor = color;
    notifyListeners();
  }

  changeChoice(String key) {
    _choice = key;
    notifyListeners();
  }

  // this is the second type of the story  [ image story  ]
  File image;
  final picker = ImagePicker();
  String imageurl;

  Future<void> getimage(String key) async {
    var pickedimage = await picker.getImage(
        source: key == 'cam' ? ImageSource.camera : ImageSource.gallery);
    image = File(pickedimage.path);
    notifyListeners();
  }

  removeimg() {
    image = null;
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (image != null) {
      notifyListeners();
      StorageReference firebasestorageref = FirebaseStorage.instance
          .ref()
          .child('storyimages')
          .child('${randomAlphaNumeric(9)}.jpg');
      final StorageUploadTask task = firebasestorageref.putFile(image);
      var downloadurl = await (await task.onComplete).ref.getDownloadURL();
      imageurl = downloadurl;
    }
  }

  setstate() {
    notifyListeners();
  }
}
