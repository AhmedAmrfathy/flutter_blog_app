import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreatePostProvider with ChangeNotifier {
  File image;
  final picker = ImagePicker();
TextEditingController textEditingController=new TextEditingController();
String imageurl;


  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    notifyListeners();
  }

 Future<void> uploadImage() async {
    if (image != null) {
      notifyListeners();
      StorageReference firebasestorageref = FirebaseStorage.instance
          .ref()
          .child('blogimages')
          .child('${randomAlphaNumeric(9)}.jpg');
      final StorageUploadTask task=firebasestorageref.putFile(image);
      var downloadurl=await(await task.onComplete).ref.getDownloadURL();
      imageurl=downloadurl;
    }
  }

}
