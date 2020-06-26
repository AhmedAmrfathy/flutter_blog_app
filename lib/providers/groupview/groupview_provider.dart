import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/group.dart';
import 'package:flutterapp/models/groupactivity.dart';

class GroupViewProvider with ChangeNotifier {
  List<GroupAvtivity> _activitylist = [
    GroupAvtivity(icon: Icons.group, title: 'Your Group'),
    GroupAvtivity(icon: Icons.directions_run, title: 'Discover'),
    GroupAvtivity(icon: Icons.add_circle, title: 'Create'),
    GroupAvtivity(icon: Icons.settings, title: 'Settings')
  ];

  List<GroupAvtivity> get activitylist {
    return [..._activitylist];
  }

  List<Group> _groups = [
    Group(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRtlzC24rAuvXjhQAdwkizVu3ujqJfPAdFpcX0cmpZU937fzBhi&usqp=CAU',
        name: 'هواة العصافير الاسترالى بالمنصوره'),
    Group(
        image:
            'https://www.rjeem.com/wp-content/uploads/2018/10/1540507188952.jpg',
        name: 'هواة العصافير الاسترالى بالمنصوره'),
    Group(
        image:
            'https://i.pinimg.com/originals/15/eb/e5/15ebe57fa215f1c06d01ded87802d898.jpg',
        name: 'هواة العصافير الاسترالى بالمنصوره'),
    Group(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT_FVmunDzo38fB9gIfKo-XxpoaYFWQRLSuLcvLZTSydf09ZaQy&usqp=CAU',
        name: 'هواة العصافير الاسترالى بالمنصوره'),
    Group(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT_FVmunDzo38fB9gIfKo-XxpoaYFWQRLSuLcvLZTSydf09ZaQy&usqp=CAU',
        name: 'هواة العصافير الاسترالى بالمنصوره'),
    Group(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT_FVmunDzo38fB9gIfKo-XxpoaYFWQRLSuLcvLZTSydf09ZaQy&usqp=CAU',
        name: 'هواة العصافير الاسترالى بالمنصوره'),
  ];
  List<Group>get groups{
    return [..._groups];
  }
}
