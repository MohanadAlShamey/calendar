import 'package:calendar/constants.dart';
import 'package:calendar/models/country_model.dart';
import 'package:calendar/services/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CountryController extends GetxController{
  var box =GetStorage(APPNAME);
  Api api=Get.find<Api>();
RxBool loading=false.obs;
  RxList countries=<CountryModel>[].obs;
  RxList countriesList=<CountryModel>[].obs;
  Rx<CountryModel> country=CountryModel().obs;
  @override
  void onInit() {
getCountries();
    super.onInit();
  }

getCountries()async{
    loading(true);
   var response= await api.getCountry();

   if(response!=null){
     List<CountryModel> list=[];
     for(var item in response){
       list.add(CountryModel.fromJson(item));
     }
     countriesList(list);
     countries(list);
   }
    loading(false);

}

}