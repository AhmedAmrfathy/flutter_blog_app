import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatStoryProvider with ChangeNotifier {
  // this is first choice of the story [ text story  ]
  String _choice = 'text';
  Color _storycolor = Colors.blueGrey;
  Color _storyfontcolor = Colors.blueGrey;

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




}
