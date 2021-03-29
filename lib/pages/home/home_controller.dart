import 'package:calendar/constants.dart';
import 'package:calendar/models/prayer_time.dart';
import 'package:calendar/services/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  Api api = Get.find<Api>();
  RxList times = <PrayerModel>[].obs;
  var box = GetStorage(APPNAME);
  RxString lattude = '40.2067573'.obs;
  RxString langtude = '18.7725767'.obs;
  RxBool loadding=false.obs;

  @override
  void onInit() {
    var pos=box.read('position');
    if(pos!=null){
      lattude.value=pos['lat'];
      langtude.value=pos['long'];
    }
    getPrayerTime();
    super.onInit();
    // getLocation();
  }

  getPrayerTime()async{
    loadding(true);
    print(lattude.value);
   var list= await api.getPrayerTime(lat:lattude.value,lang: langtude.value );
   if(list!=null){
     times(list);
   }
    loadding(false);
  }

  /*getLocation() async {
    if (box.read('location') == null) {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lattude(position.altitude.toString());
      langtude(position.longitude.toString());
      print("${lattude} , ${langtude}");
      await box.write('location', {
        'lat': position.latitude.toString(),
        'lan': position.longitude.toString()
      });
    } else {
      Map<String, String> location = box.read('location');
      lattude(location['lat']);
      langtude(location['lan']);
    }
  }*/
}




