import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/story.dart';
import 'package:video_player/video_player.dart';

class HomeViewProvider with ChangeNotifier {
  List<Story> _list = [
    Story(
        'https://ccute.cc/wp-content/uploads/2018/09/4454-4.jpg',
        'Add to story',
        'https://www.girlstiktok.com/wp-content/uploads/2020/04/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%A7%D9%86%D8%B3%D8%AA%D9%82%D8%B1%D8%A7%D9%85-3.png'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSZpG7IEZ2I7p0r5lHGG2_mr0dnEPwACfFKbC52NU_dIoXGaaEV&usqp=CAU',
        'Ibrahim mohamed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRGT6memzyms-dlkpAh3BIY8CV-UPDwo7SwZJ-mmPvtUvffPZHC&usqp=CAU'),
    Story('https://lovee.cc/wp-content/uploads/2019/08/11726.jpg', 'Mariam Ali',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-9Y-DkJQ3rbY-GCpUtQ25tp96evygNc3Z3sbslPRC-bHs-Wvo&usqp=CAU'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTG7mEw4mbUaBLCVWhmvwgy0BChfgKhRqgx4V5ppl_PdDBn1TuO&usqp=CAU',
        'Hossam Sayed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQGdR3evsiXmmC-aLjhfqrwDyF5msBZtQL6bwpw-EA_SUubRi9m&usqp=CAU'),
    Story(
        'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/88106796_2104653919679085_453797654560768000_n.jpg?_nc_cat=109&_nc_sid=85a577&_nc_ohc=t4E9e-RpUmsAX8iEz3M&_nc_ht=scontent-hbe1-1.xx&oh=d6a2aa627c8a9f7881cc1fcf3f420b0d&oe=5EE1D6DF',
        'Add to story',
        'https://www.girlstiktok.com/wp-content/uploads/2020/04/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%A7%D9%86%D8%B3%D8%AA%D9%82%D8%B1%D8%A7%D9%85-3.png'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSZpG7IEZ2I7p0r5lHGG2_mr0dnEPwACfFKbC52NU_dIoXGaaEV&usqp=CAU',
        'Ibrahim mohamed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRGT6memzyms-dlkpAh3BIY8CV-UPDwo7SwZJ-mmPvtUvffPZHC&usqp=CAU'),
    Story('https://lovee.cc/wp-content/uploads/2019/08/11726.jpg', 'Mariam Ali',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-9Y-DkJQ3rbY-GCpUtQ25tp96evygNc3Z3sbslPRC-bHs-Wvo&usqp=CAU'),
    Story(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTG7mEw4mbUaBLCVWhmvwgy0BChfgKhRqgx4V5ppl_PdDBn1TuO&usqp=CAU',
        'Hossam Sayed',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQGdR3evsiXmmC-aLjhfqrwDyF5msBZtQL6bwpw-EA_SUubRi9m&usqp=CAU')
  ];

  List<Story> get getstories {
    return [..._list];
  }

  List<Post> _listpost = [
    Post(
      'https://www.girlstiktok.com/wp-content/uploads/2020/04/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%A7%D9%86%D8%B3%D8%AA%D9%82%D8%B1%D8%A7%D9%85-3.png',
      'Amira Hassan',
      '2',
      5,
      'now we are want to have 1000 like for this fucken post',
    ),
    Post(
        'https://1.bp.blogspot.com/-7MrlRJygRoQ/XZiqJ3S_lbI/AAAAAAABsco/5zTOqq6v4pEAKmdQ5I-StLVMFVA6Z5GBgCLcBGAsYHQ/s1600/00.jpg',
        'Amira Hassan',
        '2',
        5,
        'https://ccute.cc/wp-content/uploads/2020/04/2924.jpg',
        'now we are want to have 1000 like for this fucken post'),
    Post(
        'https://www.girlstiktok.com/wp-content/uploads/2020/04/%D8%B5%D9%88%D8%B1-%D8%A8%D9%86%D8%A7%D8%AA-%D8%A7%D9%86%D8%B3%D8%AA%D9%82%D8%B1%D8%A7%D9%85-3.png',
        'Amira Hassan',
        '2',
        5,
        'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/97603370_2604854456440395_6822997501830758400_o.jpg?_nc_cat=106&_nc_sid=8024bb&_nc_ohc=nKfPzyMB76kAX_oZ1Ox&_nc_ht=scontent-hbe1-1.xx&oh=a629de9159655a4226d9a99f077c3947&oe=5EE0F491',
        'now we are want to have 1000 like for this fucken post',
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    Post(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQghOjmfc7TAPZdhZhmoQLsLojmDw0Cr5KZ3OMZNssi_25Dj_0t&usqp=CAU',
        'Amira Hassan',
        '2',
        5,
        'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/97603370_2604854456440395_6822997501830758400_o.jpg?_nc_cat=106&_nc_sid=8024bb&_nc_ohc=nKfPzyMB76kAX_oZ1Ox&_nc_ht=scontent-hbe1-1.xx&oh=a629de9159655a4226d9a99f077c3947&oe=5EE0F491',
        'now we are want to have 1000 like for this fucken post')
  ];
  List<VideoPlayerController> listofcontroller=[];

  List<Post> get getposts {
    return [..._listpost];
  }

  List<Post> get getvediospost {
    final List<Post>list = [];
    _listpost.forEach((item) {
      if (item.postvedio != null) {
        list.add(item);
      }
    });
    return list;
  }

  Future<void> initiatevedio() async {
    Future<void> initiator;
    await _listpost.forEach((item) {
      if (item.postvedio != null) {
        VideoPlayerController controller =
        VideoPlayerController.network(item.postvedio);
        initiator = controller.initialize();
        controller.setLooping(true);
        controller.setVolume(1.0);
        listofcontroller.add(controller);
      }
    });
    return initiator;
  }
}
