import 'dart:convert';

import 'package:calendar/models/prayer_time.dart';

import 'package:http/http.dart' as http;
class Api{


  Future<List<PrayerModel>> getPrayerTime({String lat='36.2067573',String lang='36.7725767'})async{
    Uri url=Uri.parse('http://api.aladhan.com/v1/calendar?latitude=$lat&longitude=$lang&year=${DateTime.now().year}&month=${DateTime.now().month}');
   print(url.toString());
    try {
     var res = await http.get(url);
     print(res.statusCode);
     print(res.body);
     var resJson = jsonDecode(res.body);
     if (res.statusCode == 200) {
       List<PrayerModel> list = [];

       for (var item in resJson['data']) {
         list.add(PrayerModel.fromJson(item));



       }
       return list;
     }
   }catch(e){
         print(e);
         return null;
   }
    //Get.find<HomeController>().times(PrayerModel.fromJson(resJson[0]['timings']));
  // print(res.body);
  }


  Future<List> getCountry()async{
    var url=Uri.parse('https://countriesnow.space/api/v0.1/countries');
    try{
      var res=await http.get(url);
      if(res.statusCode==200){
        var resJson=json.decode(res.body);
        return resJson['data'];
      }
    }on Exception catch(e){
      print(e.toString());
      return null;
    }

    return null;
  }

}