import 'dart:io';
import 'dart:convert';
import 'package:flutterapp/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ProfileScreenProvider with ChangeNotifier {
  //for getting profile data
  String id;
  String token;
  String username;
  String profilepic;
  String userjob;
  String usercountry;
  String userstatus;

  ProfileScreenProvider({this.id, this.token, this.username, this.profilepic,this.userjob,this.usercountry,this.userstatus});

  List<String> _photoslist = [];

  List<String> get photoslist {
    return [..._photoslist];
  }

  Future<void> getPhotos() async {
    final url =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/photos/$id.json?auth=$token';
    final response = await http.get(url);
    final responsedata = json.decode(response.body) as Map<String, dynamic>;
    if (responsedata != null) {
      List<String> comminglist = List();
      responsedata.forEach((key, value) {
        Map m = (value) as Map<String, dynamic>;
        comminglist.add(m['url']);
      });
      _photoslist.clear();
      _photoslist.addAll(comminglist);
      notifyListeners();
    }
  }

  // this is for editing profile data

  String profileimage;
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController jobcontroller = new TextEditingController();
  TextEditingController countrycontroller = new TextEditingController();
  String status = 'Single';

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

  Future<void> savedata() async {
    isloading = true;
    notifyListeners();
    String url =
        'https://moonlit-premise-234610.firebaseio.com/users/secretdata/$id.json?auth=$token';
    try {
      final response = await http.put(url,
          body: json.encode({
            'imgurl': profileimage,
            'name': usernamecontroller.text.toString(),
            'job': jobcontroller.text.toString(),
            'staus': status,
            'country': countrycontroller.text.toString()
          }));
      userjob=jobcontroller.text.toString();
      userstatus=status;
      usercountry=countrycontroller.text.toString();
      username = usernamecontroller.text.toString();
      final photosurl =
          'https://moonlit-premise-234610.firebaseio.com/users/secretdata/photos/$id.json?auth=$token';
      http.post(photosurl, body: json.encode({'url': profilepic}));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
