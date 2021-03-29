import 'package:calendar/pages/country/country_controller.dart';
import 'package:calendar/services/api.dart';
import 'package:get/get.dart';

class CountryBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CountryController());
    Get.lazyPut(() => Api());

  }

}