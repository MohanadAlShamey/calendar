import 'package:calendar/app/about_page.dart';
import 'package:calendar/app/country_page.dart';
import 'package:calendar/app/news_page.dart';
import 'package:calendar/app/prayer_page.dart';
import 'package:calendar/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String country;
  final currentIndex;

  HomePage({Key key, this.country = 'Aabenraa',this.currentIndex=0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(index:this.currentIndex );
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  _HomePageState({this.index});
 List<Widget> getPage(){
    return [
      PrayerPage(
        country: widget.country,
      ),
      NewsPage(),
      CountryPage(),
      AboutPage(),
    ];
  }
  
  @override
  void initState() {
   FirebaseMessaging fcm=FirebaseMessaging.instance;
   fcm.subscribeToTopic('calendar');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        child: Icon(Icons.announcement_rounded),
        backgroundColor: Color.fromARGB(255, 200, 102, 81),
        tooltip: 'about'.tr,
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 12, 104, 124),
        currentIndex: index,
        iconSize: 20,
        selectedFontSize: 12,
        unselectedFontSize: 8,
        fixedColor:Color.fromARGB(255, 12, 104, 124),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('home'.tr,style: GoogleFonts.cairo(color:index == 0
                ? Color.fromARGB(255, 200, 102, 81)
                : Colors.white),),
            tooltip: 'home'.tr,
            icon: Icon(Icons.home,
                color: index == 0
                    ? Color.fromARGB(255, 200, 102, 81)
                    : Colors.white),
          ),
          BottomNavigationBarItem(
            title: Text('news'.tr,style: GoogleFonts.cairo(color:index == 1
                ? Color.fromARGB(255, 200, 102, 81)
                : Colors.white),),
            tooltip: 'news'.tr,
            icon: Icon(Icons.notifications_active_outlined,
                color: index == 1
                    ? Color.fromARGB(255, 200, 102, 81)
                    : Colors.white),
          ),
          BottomNavigationBarItem(
            title: Text('country'.tr,style: GoogleFonts.cairo(color:index == 2
                ? Color.fromARGB(255, 200, 102, 81)
                : Colors.white),),
            tooltip: 'country'.tr,
            icon: Icon(Icons.pin_drop,
                color: index == 2
                    ? Color.fromARGB(255, 200, 102, 81)
                    : Colors.white),
          ),
          BottomNavigationBarItem(
            title: Text('about_us'.tr,style: GoogleFonts.cairo(color:index == 3
                ? Color.fromARGB(255, 200, 102, 81)
                : Colors.white),),
            tooltip: 'about_us'.tr,
            icon: Icon(Icons.insert_drive_file_outlined,
                color: index == 3
                    ? Color.fromARGB(255, 200, 102, 81)
                    : Colors.white),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/imgs/bg.png'), fit: BoxFit.cover)),
        padding: const EdgeInsets.only(top: 35.0),
        child: Stack(
          children: [
getPage()[index],
            Positioned(
              top: 15,
              child: PopupMenuButton(
                enabled: true,
                // initialValue: 'ar',
                onSelected: (select) {
                  changeLang(select);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('ar'.tr),
                    value: 'ar',
                  ),
                  PopupMenuItem(
                    child: Text('dn'.tr),
                    value: 'dn',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeLang(String lang) async {
    GetStorage box = GetStorage(APPNAME);
    print(lang);
    if (box.hasData('lang')) {
      box.remove('lang');
    }
    await box.write('lang', lang);
    setState(() {
      Locale local = Locale(lang);
      Get.updateLocale(local);
    });
  }
}
