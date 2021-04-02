import 'dart:async';

import 'package:calendar/constants.dart';
import 'package:calendar/models/prayer_time.dart';
import 'package:calendar/services/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  Api api = Get.find<Api>();
  RxList times = <PrayerModel>[].obs;
  var box = GetStorage(APPNAME);
  RxString lattude = '40.2067573'.obs;
  RxString langtude = '18.7725767'.obs;
  RxBool loadding = false.obs;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  Rx<DateTime> time = DateTime.now().obs;
  FlutterLocalNotificationsPlugin notificationsPlugin;
  var location = Location();
Rx<PrayerModel> pryerTimes=PrayerModel().obs;


  getTimeZoneList(){
    var locations = tz.timeZoneDatabase.locations;
  var list= locations.values;
  for(var it in list){
    print(it);
  }
  }

  @override
  void onInit() {

    tz.initializeTimeZones();
    tz.TZDateTime.from(DateTime.now(), tz.local);
    getTimeZoneList();
    fcm.subscribeToTopic('calendar');
    var pos = box.read('position');
    if (pos != null) {
      lattude.value = pos['lat'];
      langtude.value = pos['long'];
    }
    getPrayerTime();
    super.onInit();
  }

  Future<void> getPrayerTime() async {
    loadding(true);
    print(lattude.value);
    var list =
        await api.getPrayerTime(lat: lattude.value, lang: langtude.value);
    if (list != null) {
      times(list);
      getTimesDay();
    }
    loadding(false);
  }

  getTimesDay(){
    List<PrayerModel> list=times.value;
    var time=list.where((el){
      var date=el.gorgeanDateModel.date;

      var year=int.parse(date.split('-')[2]);
      var month=int.parse(date.split('-')[1]);
      var day=int.parse(date.split('-')[0]);
     var currentYear=DateTime.now().year;
     var currentMonth=DateTime.now().month;
     var currentDay=DateTime.now().day;
      if(DateTime(year,month,day).compareTo(DateTime(currentYear,currentMonth,currentDay))==0){
        return true;
      }
      return false;
    });

    pryerTimes(time.first);
  }

  /*
 * Notification Local
 * */
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    var android = AndroidInitializationSettings('ic_launcher');
    var ios = IOSInitializationSettings();
    var initSitting = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSitting,
        onSelectNotification: selectNotify);
    print('readyControllerIS');

    if (times.value.length > 0) {
      for (PrayerModel item in times.value) {
        print('DATE : ${item.gorgeanDateModel.date}');
      }
    }
  }

  Future selectNotify(String payload) {
    print('helo');
  }

  void showNotify([DateTime time, String title, String body]) {
print(tz.TZDateTime.now(tz.getLocation('Africa/Cairo')));

    var android = AndroidNotificationDetails(
      "C1",
      'C1',
      'C1 Desc',

      progress: 10000,
      maxProgress: 15000,
      autoCancel: false,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('azan'),
      enableVibration: true,
      importance: Importance.max,
      channelShowBadge: true,
      category: 'Remendar',
      ticker: 'ticker',
      onlyAlertOnce: true,
      showWhen: false,

    );
   // var x=AndroidNotificationDetails();
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime(tz.getLocation('Africa/Cairo'),time.year,time.month,time.day,time.hour,time.minute), platform,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,matchDateTimeComponents: DateTimeComponents.time);

    /*flutterLocalNotificationsPlugin.schedule(0, title, body, time, platform,
        payload: 'SendMessage',androidAllowWhileIdle: true,);*/
  }



}
