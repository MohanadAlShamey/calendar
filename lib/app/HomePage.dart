import 'package:calendar/app/country_page.dart';
import 'package:calendar/app/news_page.dart';
import 'package:calendar/app/prayer_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String country;

   HomePage({Key key, this.country='Aabenraa'}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/imgs/bg.png'),fit: BoxFit.cover)
        ),
        padding: const EdgeInsets.only(top:35.0),
        child: PageView(
          children: [
PrayerPage(country: widget.country,),
            NewsPage(),
          ],
        ),
      ),
    );
  }
}
