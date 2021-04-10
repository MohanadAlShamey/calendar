import 'package:calendar/app/api.dart';
import 'package:calendar/app/prayer_time_model.dart';
import 'package:calendar/app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libcalendar/libcalendar.dart';

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
    await notification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(),
        err.length > 0
            ? Center(
                child: Text('$err'),
              )
            : Container(),
        model != null
            ? Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                    fromGregorianToIslamic(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day)
                                .month ==
                            9
                        ? Container(
                            margin: EdgeInsets.only(bottom: 15),
                            height: 60,
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
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                                'fjr'.tr,
                                style: Styles.prayerTimeStyle,
                              ),
                              Text(
                                '${model.fajr}',
                                style: Styles.prayerTimeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                                style: Styles.prayerTimeStyle,
                              ),
                              Text(
                                '${model.shuroq}',
                                style: Styles.prayerTimeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                                style: Styles.prayerTimeStyle,
                              ),
                              Text(
                                '${model.dhuhr}',
                                style: Styles.prayerTimeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                                style: Styles.prayerTimeStyle,
                              ),
                              Text(
                                '${model.asr}',
                                style: Styles.prayerTimeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                                style: Styles.prayerTimeStyle,
                              ),
                              Text(
                                '${model.magrib}',
                                style: Styles.prayerTimeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 60,
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
                                style: Styles.prayerTimeStyle,
                              ),
                              Text(
                                '${model.isha}',
                                style: Styles.prayerTimeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    ));
  }

  Future onselect(String payload) {}

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'ImsakChannel',
      'Imsak',
      'Imsak Ahdhn',
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

    await flutterLocalNotificationsPlugin.schedule(
      0,
      'dhrnow'.tr,
      '',
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
          int.parse(model.dhuhr.split(':')[0]),
          int.parse(model.dhuhr.split(':')[1])
      ),
      notificationDetails,
    );

    await flutterLocalNotificationsPlugin.schedule(
      1,
      'asrnow'.tr,
      '',
      DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(model.asr.split(':')[0]),
          int.parse(model.asr.split(':')[1])
      ),
      notificationDetails,
    );
  }
}
