import 'package:calendar/langs/translate_app.dart';
import 'package:calendar/route/page_app.dart';
import 'package:calendar/route/route_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp();
    await GetStorage.init(APPNAME);
  }catch(e){
    print(e);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.topLevel,
      debugShowCheckedModeBanner: false,
      title: 'app_name'.tr,
      translations: TranslateApp(),
      getPages: PageApp.Pages,
      initialRoute: RoutesApp.HOMEPAGE,
      locale: Locale('ar'),
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

    );
  }
}

