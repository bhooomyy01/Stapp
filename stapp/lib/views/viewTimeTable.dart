import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stapp/Widgets/widgetapp.dart';

class ViewTimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Container(
            child: PhotoView(
          imageProvider: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/aadhyainnovation-69046.appspot.com/o/TimeTableFloder%2FTimeTableImage?alt=media&token=8294fec1-062d-476d-8dec-7e0cb421fb3b"),
        )));
  }
}
