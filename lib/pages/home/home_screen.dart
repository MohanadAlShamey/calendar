import 'dart:ui';

import 'package:calendar/models/prayer_time.dart';
import 'package:calendar/pages/my_app_bar.dart';
import 'package:calendar/route/route_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:libcalendar/libcalendar.dart';

import '../../constants.dart';
import 'home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  var box = GetStorage(APPNAME);
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  List days = [
    'sun'.tr,
    'mon'.tr,
    'tus'.tr,
    'wed'.tr,
    'thir'.tr,
    'fri'.tr,
    'sat'.tr
  ];

  List months = [
    '1'.tr,
    '2'.tr,
    '3'.tr,
    '4'.tr,
    '5'.tr,
    '6'.tr,
    '7'.tr,
    '8'.tr,
    '9'.tr,
    '10'.tr,
    '11'.tr,
    '12'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    print("$year , $month ,$day");
    // controller.showNotify(DateTime(2021,4,2,12,20,30),'موعد آذان المغرب','إفطارا شهيا');
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            title: Text(
              'home'.tr,
              style: TextStyle(color: Colors.white),
            ),
            icon: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(RoutesApp.NEWSPAGE);
                }),
          ),
          BottomNavigationBarItem(
            title: Text('news'.tr, style: TextStyle(color: Colors.white)),
            icon: IconButton(
                icon: Icon(
                  Icons.notification_important,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(RoutesApp.NEWSPAGE);
                }),
          ),
          BottomNavigationBarItem(
            title: Text('location'.tr, style: TextStyle(color: Colors.white)),
            icon: IconButton(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  var pos = await controller.location.getLocation();
                  controller.lattude.value = pos.latitude.toString();
                  controller.langtude.value = pos.longitude.toString();
                  controller.getPrayerTime();
                  await box.write('position', {
                    'lat': pos.latitude.toString(),
                    'long': pos.longitude.toString()
                  });
                }),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/imgs/bg.jpg',
                    ),
                    fit: BoxFit.cover)),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              visible: controller.loadding.value ||
                  controller.pryerTimes.value.asr == null,
            ),
          ),
          Obx(
            () {
              PrayerModel prayer = controller.pryerTimes.value;
              getNotifyByTime(prayer);

              return Visibility(
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 75,
                          margin: EdgeInsets.only(bottom: 15),
                          child: Card(
                            color: Colors.red.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${days[fromGregorianToIslamic(year, month, day).weekday]}",
                                  style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${fromGregorianToIslamic(year, month, day).day}",
                                  style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${months[fromGregorianToIslamic(year, month, day).month - 1]}",
                                  style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                       fromGregorianToIslamic(year, month, day).month-1==9? Container(
                          height: 75,
                          child: Card(
                            color: Colors.white.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  prayer.imsak.toString().split(' ')[0],
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'emsaq'.tr,
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ):Container(),
                        Container(
                          height: 75,
                          child: Card(
                            color: Colors.white.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  prayer.fajr.toString().split(' ')[0],
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'fjr'.tr,
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 75,
                          child: Card(
                            color:  Colors.white.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  prayer.dhuhr.toString().split(' ')[0],
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'doher'.tr,
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 75,
                          child: Card(
                            color: Colors.white.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  prayer.asr.toString().split(' ')[0],
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'asr'.tr,
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 75,
                          child: Card(
                            color: Colors.white.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  prayer.maghrib.toString().split(' ')[0],
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'mogreb'.tr,
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 75,
                          child: Card(
                            color:  Colors.white.withAlpha(120),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  prayer.isha.toString().split(' ')[0],
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'esha'.tr,
                                  style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                visible: !controller.loadding.value ||
                    controller.pryerTimes.value.asr != null,
              );
            },
          ),
        ],
      ),
    );
  }

  getNotifyByTime(PrayerModel prayer) {
    //print(prayer.fajr.split(' ')[0].split(':')[1]);
    int fjrHour=int.parse(prayer.fajr.split(' ')[0].split(':')[0]);
    int fjrMin=int.parse(prayer.fajr.split(' ')[0].split(':')[1]);

    int dhrHour=int.parse(prayer.dhuhr.split(' ')[0].split(':')[0]);
    int dhrMin=int.parse(prayer.dhuhr.split(' ')[0].split(':')[1]);

    int asrHour=int.parse(prayer.asr.split(' ')[0].split(':')[0]);
    int asrMin=int.parse(prayer.asr.split(' ')[0].split(':')[1]);

    int mHour=int.parse(prayer.maghrib.split(' ')[0].split(':')[0]);
    int mMin=int.parse(prayer.maghrib.split(' ')[0].split(':')[1]);


    int eshaHour=int.parse(prayer.isha.split(' ')[0].split(':')[0]);
    int eshaMin=int.parse(prayer.isha.split(' ')[0].split(':')[1]);
if(fromGregorianToIslamic(year,month,day).month-1==9){
  int emsakHour=int.parse(prayer.asr.split(' ')[0].split(':')[0]);
  int emsakMin=int.parse(prayer.asr.split(' ')[0].split(':')[1]);
  controller.showNotify(DateTime(year,month,day,emsakHour,emsakMin),'emsaknow'.tr,'');
}

    controller.showNotify(DateTime(year,month,day,dhrHour,dhrMin),'dhrnow'.tr,'');
    controller.showNotify(DateTime(year,month,day,asrHour,asrMin),'asrnow'.tr,'');
    controller.showNotify(DateTime(year,month,day,eshaHour,eshaMin),'ishanow'.tr,'');
    controller.showNotify(DateTime(year,month,day,mHour,mMin),'magrebnow'.tr,'');
    controller.showNotify(DateTime(year,month,day,fjrHour,fjrMin),'fjrnow'.tr,'');
   // controller.showNotify(DateTime(year,month,day,21,1),'fjrnow'.tr,'');


  }
}
