import 'package:calendar/pages/country/country_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryScreen extends GetWidget<CountryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Container(
              child: Card(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'search'.tr
                  ),
                  onChanged: (value) {
                    controller.countries.value = controller
                        .countriesList.value
                        .where((el) => el.country
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Expanded(
                          child: Obx(
                            () => controller.countries.length > 0
                                ? Visibility(
                                    child: Container(
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              print(
                                                  controller.countries[index].cities);
                                              controller.country.value =
                                                  controller.countries[index];
                                            },
                                            child: Card(
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                      "${controller.countries[index].country}"
                                                          .toUpperCase()),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: controller.countries.length,
                                      ),
                                    ),
                                    visible: controller.countries.length > 0,
                                  )
                                : Visibility(
                                    child:
                                        Center(child: CircularProgressIndicator())),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => controller.country.value.country != null
                        ? Flexible(
                            flex: 2,
                            child: controller.country.value.country != null
                                ? Obx(
                                    () => Visibility(
                                      child: Container(
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                      "${controller.country.value.cities[index].toUpperCase()}"
                                                          .toUpperCase()),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount:
                                              controller.country.value.cities.length,
                                        ),
                                      ),
                                      visible: controller.country.value != null,
                                    ),
                                  )
                                : Center(
                                    child: Text('choose_country'.tr),
                                  ),
                          )
                        : Center(
                            child: Text('choose_country'.tr),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
