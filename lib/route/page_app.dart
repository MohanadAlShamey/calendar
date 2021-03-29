
import 'package:calendar/pages/country/country_binding.dart';
import 'package:calendar/pages/country/country_screen.dart';
import 'package:calendar/pages/home/home_binding.dart';
import 'package:calendar/pages/home/home_screen.dart';
import 'package:calendar/pages/posts/posts_screen.dart';
import 'package:calendar/route/route_app.dart';
import 'package:get/get.dart';

class PageApp {
  static List<GetPage> Pages = [
    GetPage(
      name: RoutesApp.COUNTRYPAGE,
      page: () => CountryScreen(),
      binding: CountryBinding(),
    ),
    GetPage(
      name: RoutesApp.INITIALPAGE,
      page: () => CountryScreen(),
      binding: CountryBinding(),
    ),

    GetPage(
      name: RoutesApp.HOMEPAGE,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesApp.NEWSPAGE,
      page: () => PostScreen(),
      //binding: HomeBinding(),
    ),
  ];
}
