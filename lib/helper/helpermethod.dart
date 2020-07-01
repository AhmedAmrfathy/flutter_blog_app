import 'package:flutter/material.dart';
import 'package:flutterapp/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class HelperMethod {
  static const Color red=  Color(0xffef5350);
  static const Color blue=  Color(0xff2196f3);
  static const Color lightgreen=  Color(0xffccff90);
  static const Color yellow=  Color(0xffeeff41);
  static const Color white=  Color(0xffffffff);
  static const Color lightgrey=  Color(0xffd6d6d6);
  static const Color black=  Color(0xff000000);







  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static String getduration(String date) {
    DateTime dateTime = DateTime.parse(date);
    int duration = DateTime.now().difference(dateTime).inMinutes;
    var last = '';
    if (duration == 0) {
      return 'now';
    } else {
      if (duration <= 59) {
        last = duration.toString() +' '+ 'm';
      } else if (duration > 59) {
        int result = (duration / 60).floor();
        print(result);
        if (result < 24) {
          last = result.toString() +' '+ 'h';
        } else {
          last = (result / 24).floor().toString()+' '+'d';
        }
      }
      return last;
    }
  }

  static Future getImage(ImagePicker picker, File image) async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
  }

  static Future showerrordialog(String massage, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('an error occured'),
              content: Text('an error was thrown by the way'),
              actions: <Widget>[
                FlatButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    })
              ],
            ));
  }
}
