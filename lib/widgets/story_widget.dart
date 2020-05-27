import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String photo;
  final String text;
  final String circlephoto;

  StoryWidget(this.photo, this.text, this.circlephoto);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 6),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              photo,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(circlephoto),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            left: 3,
            child: Text(
              text,
              style: TextStyle(color: Colors.white,fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
