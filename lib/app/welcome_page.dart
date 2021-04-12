import 'dart:ui';

import 'package:calendar/app/HomePage.dart';
import 'package:calendar/app/styles.dart';
import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:get/get.dart';
import 'country_page.dart';


class WelcomePage extends StatelessWidget {
  GetStorage box=GetStorage(APPNAME);
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text('app_name'.tr,style: GoogleFonts.cairo(color:Colors.white,fontSize: 25),),
      seconds: 4,

      navigateAfterSeconds: getPage(),
      loadingText: Text('info'.tr,style: Styles.AboutBodyStyle,textAlign: TextAlign.center,),
     image: Image.asset('assets/imgs/logo.png'),
     imageBackground: AssetImage('assets/imgs/bg.png'),
      photoSize: 150,
     // useLoader: true,
      
    );
  }

  getPage(){
    String country=box.read('country');
    if(country!=null){
      return HomePage(country: country,);
    }
    return HomePage(currentIndex: 2,);
  }
}
