
import 'package:calendar/constants.dart';
import 'package:calendar/pages/posts/posts_screen.dart';
import 'package:calendar/route/route_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

import 'home/home_controller.dart';

class MyAppBar extends GetWidget<HomeController> implements PreferredSizeWidget {
  Location location=Location();
  var box =GetStorage(APPNAME);
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('app_name'.tr),
      ),
      actions: [

      ],
    );


    /* Container(
      color: Colors.blue.shade700,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: (){}),
          IconButton(icon: Icon(Icons.calendar_today), onPressed: (){}),
          IconButton(icon: Icon(Icons.calendar_today), onPressed: (){}),
        ],
      ),
    );*/
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75);
}
