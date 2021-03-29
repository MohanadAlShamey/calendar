import 'package:calendar/pages/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  @override
  var day = DateTime
      .now()
      .day;

  Widget build(BuildContext context) {
    print(controller.times.length);
    return Scaffold(
      appBar: MyAppBar(),
      body: Obx(() {
        print("LENGTH ${controller.times.length}");
        return controller.loadding.value ? Center(
          child: CircularProgressIndicator(),) :
        ListView(
          scrollDirection: Axis.vertical,
          children: [
            controller.times.length > 0 ? Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: Get.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 1],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.green.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(child: Text(
                            controller.times[day - 1].gorgeanDateModel.date),),
                        Center(child: Text(
                            controller.times[day - 1].hijri.date),),
                        Center(child: Text(
                            controller.times[day - 1].hijri.month),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('emsaq'.tr),
                                  ],
                                ),
                                //Text('after'.tr),
                                Text(controller.times.value[day - 1].imsak
                                    .substring(0, 5)),


                              ],
                            )),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('fjr'.tr),
                                  ],
                                ),
                                Text(controller.times.value[day - 1].fajr
                                    .substring(0, 5)),
                                //Text('after'.tr + ' 5 ساعات'),

                              ],
                            )),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('shorooq'.tr),
                                  ],
                                ),
                                Text(controller.times.value[day - 1].sunrise
                                    .substring(0, 5)),
                                //Text('after'.tr + ' 5 ساعات'),

                              ],
                            )),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('doher'.tr),
                                  ],
                                ),
                                Text(controller.times.value[day - 1].dhuhr
                                    .substring(0, 5)),
                                //Text('after'.tr + ' 5 ساعات'),

                              ],
                            )),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('asr'.tr),
                                  ],
                                ),
                                Text(controller.times.value[day - 1].asr
                                    .substring(0, 5)),
                                //Text('after'.tr + ' 5 ساعات'),

                              ],
                            )),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('mogreb'.tr),
                                  ],
                                ),
                                Text(controller.times.value[day - 1].maghrib
                                    .substring(0, 5)),
                                //Text('after'.tr + ' 5 ساعات'),

                              ],
                            )),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.blue.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('esha'.tr),
                                  ],
                                ),
                                Text(controller.times.value[day - 1].isha
                                    .substring(0, 5)),
                                //Text('after'.tr + ' 5 ساعات'),

                              ],
                            ),),
                      ),
                    ),
                  ),

                ],
              ),
            ) : Container(child: Center(child: Text('not'),),),
          ],
        );
      }

      ),
    );
  }
}
