import 'dart:convert';

import 'package:calendar/app/prayer_time_model.dart';
import 'package:http/http.dart' as http;
class CalendarApi{


  Future<PrayerTimeModel> getPrayerTime(String country)async{
    http.Response res=await http.get(Uri.parse('http://calendar.hwa70.com/api/prayer/$country'));
    print(res.body);
    if(res.statusCode==200){
     var resJson=jsonDecode(res.body)['prayer'];
     PrayerTimeModel model=PrayerTimeModel.fromJson(resJson);
     return model;

    }
    return null;
  }
  
}