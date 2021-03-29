import 'package:calendar/models/gorgian_date_model.dart';
import 'package:calendar/models/hijri_date_model.dart';

class PrayerModel {
  String fajr;
  String sunrise;
  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  String imsak;
  String midnight;
  GorgeanDateModel gorgeanDateModel;
  HijriModel hijri;

  PrayerModel({this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight, this.gorgeanDateModel, this.hijri});

  PrayerModel.fromJson(Map<String, dynamic> json) {
    fajr = json['timings']['Fajr'];
    sunrise = json['timings']['Sunrise'];
    dhuhr = json['timings']['Dhuhr'];
    asr = json['timings']['Asr'];
    sunset = json['timings']['Sunset'];
    maghrib = json['timings']['Maghrib'];
    isha = json['timings']['Isha'];
    imsak = json['timings']['Imsak'];
    midnight = json['timings']['Midnight'];
    this.gorgeanDateModel = GorgeanDateModel(
        date: json['date']['gregorian']['date'],
        day: json['date']['gregorian']['day'],
        dayname: json['date']['gregorian']['weekday']['en']
    );
    this.hijri = HijriModel(
      date: json['date']['hijri']['date'],
      day: json['date']['hijri']['day'],
      dayname: json['date']['hijri']['weekday']['ar'],
      month: json['date']['hijri']['month']['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Sunrise'] = this.sunrise;
    data['Dhuhr'] = this.dhuhr;
    data['Asr'] = this.asr;
    data['Sunset'] = this.sunset;
    data['Maghrib'] = this.maghrib;
    data['Isha'] = this.isha;
    data['Imsak'] = this.imsak;
    data['Midnight'] = this.midnight;
    return data;
  }

  Map m = {
    "timings": {
      "Fajr": "04:53 (EET)",
      "Sunrise": "06:03 (EET)",
      "Dhuhr": "11:45 (EET)",
      "Asr": "14:58 (EET)",
      "Sunset": "17:28 (EET)",
      "Maghrib": "17:28 (EET)",
      "Isha": "18:38 (EET)",
      "Imsak": "04:43 (EET)",
      "Midnight": "23:45 (EET)"
    },
    "date": {
      "readable": "01 Mar 2021",
      "timestamp": "1614582061",
      "gregorian": {
        "date": "01-03-2021",
        "format": "DD-MM-YYYY",
        "day": "01",
        "weekday": {
          "en": "Monday"
        },
        "month": {
          "number": 3,
          "en": "March"
        },
        "year": "2021",
        "designation": {
          "abbreviated": "AD",
          "expanded": "Anno Domini"
        }
      },
      "hijri": {
        "date": "17-07-1442",
        "format": "DD-MM-YYYY",
        "day": "17",
        "weekday": {
          "en": "Al Athnayn",
          "ar": "الاثنين"
        },
        "month": {
          "number": 7,
          "en": "Rajab",
          "ar": "رَجَب"
        },
        "year": "1442",
        "designation": {
          "abbreviated": "AH",
          "expanded": "Anno Hegirae"
        },
        "holidays": []
      }
    },
    "meta": {
      "latitude": 36.2067573,
      "longitude": 36.7725767,
      "timezone": "Asia/Damascus",
      "method": {
        "id": 2,
        "name": "Islamic Society of North America (ISNA)",
        "params": {
          "Fajr": 15,
          "Isha": 15
        }
      },
      "latitudeAdjustmentMethod": "ANGLE_BASED",
      "midnightMode": "STANDARD",
      "school": "STANDARD",
      "offset": {
        "Imsak": 0,
        "Fajr": 0,
        "Sunrise": 0,
        "Dhuhr": 0,
        "Asr": 0,
        "Maghrib": 0,
        "Sunset": 0,
        "Isha": 0,
        "Midnight": 0
      }
    }
  };
}
