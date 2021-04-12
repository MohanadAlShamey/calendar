import 'package:calendar/app/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: Column(
        children: [
          SizedBox(height: 25,),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/imgs/logo.png'),fit: BoxFit.contain),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('about'.tr,style: Styles.AboutTitleStyle,),
                    Text('about_body'.tr,style: Styles.AboutBodyStyle,),
                    Text('body1'.tr,style: Styles.AboutBodyStyle,),
                    Text('body2'.tr,style: Styles.AboutBodyStyle,),
                    Text('body4'.tr,style: Styles.AboutBodyStyle,),
                    Text('body5'.tr,style: Styles.AboutBodyStyle,),
                    Text('body6'.tr,style: Styles.AboutBodyStyle,),
                    Text('body7'.tr,style: Styles.AboutBodyStyle,),
                    Text('body8'.tr,style: Styles.AboutBodyStyle,),
                    Text('and_other'.tr,style: Styles.AboutBodyStyle,),
                    Text('vesion'.tr,style: Styles.AboutTitleStyle,),
                    Text('vesion_body'.tr,style: Styles.AboutBodyStyle,),
                    Text('message'.tr,style: Styles.AboutTitleStyle,),
                    Text('message_body'.tr,style: Styles.AboutBodyStyle,),
                    Text('qeam'.tr,style: Styles.AboutTitleStyle,),
                    Text('qeam_body1'.tr,style: Styles.AboutBodyStyle,),
                    Text('qeam_body2'.tr,style: Styles.AboutBodyStyle,),
                    Text('qeam_body3'.tr,style: Styles.AboutBodyStyle,),
                    Text('qeam_body4'.tr,style: Styles.AboutBodyStyle,),
                    SizedBox(height: 10,),





                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
