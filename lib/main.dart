
import 'package:calendar/app/welcome_page.dart';
import 'package:calendar/langs/translate_app.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'constants.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp();
    await GetStorage.init(APPNAME);
  }catch(e){
    print(e);
  }
  await tz.initializeTimeZones();
  final String timeZoneName ='Europe/Copenhagen';
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  runApp(MyApp());

}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetStorage box =GetStorage(APPNAME);
  Locale locale;
 void getLocale(){
   if(box.hasData('lang')){
     setState(() {
       locale=Locale(box.read('lang'));

     });
   }else{
     setState(() {
       locale=Locale('dn');
     });
   }
 }
@override
  void initState() {
   getLocale();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.topLevel,
      debugShowCheckedModeBanner: false,
      title: 'إمساكية رمضان',
      translations: TranslateApp(),
     // getPages: PageApp.Pages,
      //initialRoute: RoutesApp.COUNTRYPAGE,
      locale:locale,
      fallbackLocale: Locale('ar'),
      home: WelcomePage(),
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

    );
  }
}

