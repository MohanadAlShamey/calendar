import 'package:calendar/app/api.dart';
import 'package:calendar/app/prayer_time_model.dart';
import 'package:calendar/app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:libcalendar/libcalendar.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PrayerPage extends StatefulWidget {
  final String country;

  PrayerPage({this.country = 'Aabenraa'});

  @override
  _PrayerPageState createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  PrayerTimeModel model;
  bool loading = false;
  String err = '';

  List<String> days = ['mon', 'tus', 'wed', 'thir', 'fri', 'sat', 'sun'];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  initNotify() async {
    androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    iosInitializationSettings = IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onselect);
  }

  TextStyle getStyle(String today, String time, String next,{isIsha=false}) {
    DateTime nowTime = DateTime.parse('$today $time');
    DateTime now = DateTime.now();
    DateTime nexttime = DateTime.parse('$today $next');
    if(isIsha){
      nexttime.add(Duration(days: 1));
    }
    print("${time} - ${DateTime.now().compareTo(nowTime)}");
    if (now.compareTo(nowTime) > 0 && now.compareTo(nexttime) < 0) {
      return Styles.prayerTimeStyleNow;
    }
    return Styles.prayerTimeStyle;
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    CalendarApi().getPrayerTime(widget.country).then((value) {
      setState(() {
        if (value != null) {
          model = value;
          showNotfy();
        } else {
          err = 'لا يوجد إتصال بالسيرفر';
        }
        loading = false;
      });
    });

    super.initState();
    initNotify();
  }

  showNotfy() async {
    await notification(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              //margin: EdgeInsets.only(bottom: 3),
              height: 120,

              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/imgs/ramadan.png'),
                    fit: BoxFit.fitHeight),
              ),
            ),
            if (loading) Center(
              child: CircularProgressIndicator(),
            ) ,
            if (err.length > 0) Center(
              child: Text('$err'),
            ) ,
            if (model != null) Expanded(
              child: ListView(
                padding: EdgeInsets.all(1),
                children: [
                  Center(
                    child: Text(
                      '${model.country}',
                      style: Styles.DateStyle,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${DateTime.now().year} - ${fromGregorianToIslamic(DateTime.now().year, DateTime.now().month, DateTime.now().day).year}',
                      style: Styles.DateStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${days[DateTime.now().weekday - 1]}'.tr,
                              style: Styles.DateStyle,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${fromGregorianToIslamic(DateTime.now().year, DateTime.now().month, DateTime.now().day).day}',
                                  style: Styles.DateStyle,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${fromGregorianToIslamic(DateTime.now().year, DateTime.now().month, DateTime.now().day).month}'
                                      .tr,
                                  style: Styles.DateStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.white,
                    ),
                  ),
                  if (fromGregorianToIslamic(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day)
                      .month ==
                      9) Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'emsaq'.tr,
                              style: Styles.prayerTimeStyle,
                            ),
                            Text(
                              '${model.imsak}',
                              style: Styles.prayerTimeStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) ,
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      //color: Colors.yellow.withOpacity(0.3),
                      image: DecorationImage(
                        image: AssetImage('assets/imgs/list.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'fjr'.tr,
                              style: getStyle(
                                  model.today, model.fajr, model.shuroq),
                            ),
                            Text(
                              '${model.fajr}',
                              style: getStyle(
                                  model.today, model.fajr, model.shuroq),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'shorooq'.tr,
                              style: getStyle(
                                  model.today, model.shuroq, model.dhuhr),
                            ),
                            Text(
                              '${model.shuroq}',
                              style: getStyle(
                                  model.today, model.shuroq, model.dhuhr),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'doher'.tr,
                              style: getStyle(
                                  model.today, model.dhuhr, model.asr),
                            ),
                            Text(
                              '${model.dhuhr}',
                              style: getStyle(
                                  model.today, model.dhuhr, model.asr),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'asr'.tr,
                              style: getStyle(
                                  model.today, model.asr, model.magrib),
                            ),
                            Text(
                              '${model.asr}',
                              style: getStyle(
                                  model.today, model.asr, model.magrib),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'mogreb'.tr,
                              style: getStyle(
                                  model.today, model.magrib, model.isha),
                            ),
                            Text(
                              '${model.magrib}',
                              style: getStyle(
                                  model.today, model.magrib, model.isha),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/imgs/list.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'esha'.tr,
                              style: getStyle(
                                  model.today, model.isha, model.fajr,isIsha: true),
                            ),
                            Text(
                              '${model.isha}',
                              style: getStyle(
                                  model.today, model.isha, model.fajr,isIsha: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),




                ],
              ),
            ) ,
          ],
        ));
  }

  Future onselect(String payload) {}

  Future<void> notification(int id) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'ImsakChannel$id}',
      'Imsak$id',
      'Imsak Ahdhn$id',
      priority: Priority.max,
      playSound: true,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('azan'),
      ticker: 'test',
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosNotificationDetails,
      android: androidNotificationDetails,
    );
    DateTime dhr = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(model.dhuhr.split(':')[0]),
        int.parse(model.dhuhr.split(':')[1]),
        0);
    DateTime now = DateTime.now();
    tz.TZDateTime tzDate =
        tz.TZDateTime.local(now.year, now.month, now.day, now.hour, now.minute);
    print("${now}   ---   ${tzDate}");

  /*  if (DateTime.now().compareTo(dhr) <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'dhrnow'.tr,
        '',
        tz.TZDateTime.local(
            dhr.year, dhr.month, dhr.day, dhr.hour, dhr.minute, 0),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'Any',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }*/


    DateTime asr = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(model.asr.split(':')[0]),
        int.parse(model.asr.split(':')[1]),
        0);
   /* if (DateTime.now().compareTo(asr) <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id + 1,
        'asrnow'.tr,
        '',
        tz.TZDateTime.local(
            asr.year, asr.month, asr.day, asr.hour, asr.minute, 0),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'Any',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }*/

    DateTime magrib = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(model.magrib.split(':')[0]),
        int.parse(model.magrib.split(':')[1]),
        0);
    if (DateTime.now().compareTo(magrib) <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id + 2,
        'magrebnow'.tr,
        '',
        tz.TZDateTime.local(magrib.year, magrib.month, magrib.day, magrib.hour,
            magrib.minute, 0),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'Any',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    DateTime isha = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(model.isha.split(':')[0]),
        int.parse(model.isha.split(':')[1]),
        0);
  /*  if (DateTime.now().compareTo(isha) <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id + 3,
        'ishanow'.tr,
        '',
        tz.TZDateTime.local(
            isha.year, isha.month, isha.day, isha.hour, isha.minute, 0),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'Any',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }*/

    DateTime fajr = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(model.fajr.split(':')[0]),
        int.parse(model.fajr.split(':')[1]),
        0);
   /* if (DateTime.now().compareTo(fajr) <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id + 4,
        'fjrnow'.tr,
        '',
        tz.TZDateTime.local(
            fajr.year, fajr.month, fajr.day, fajr.hour, fajr.minute, 0),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'Any',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }*/

    DateTime imsak = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1,
        int.parse(model.imsak.split(':')[0]),
        int.parse(model.imsak.split(':')[1]),
        0);
    if (DateTime.now().compareTo(imsak) <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id + 5,
        'emsaknow'.tr,
        '',
        tz.TZDateTime.local(
            imsak.year, imsak.month, imsak.day, imsak.hour, imsak.minute, 0),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'Any',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
