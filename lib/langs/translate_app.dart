import 'package:calendar/langs/ar.dart';
import 'package:calendar/langs/dn.dart';
import 'package:calendar/langs/en.dart';
import 'package:get/get.dart';

class TranslateApp extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    'ar':ar,
    'en':en,
    'dn':dn
  };

}