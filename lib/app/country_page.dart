import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  GetStorage box=GetStorage(APPNAME);
  List<String> countries = [
    "Aabenraa",
    "Aalborg",
    "Aarhus",
    "Assens",
    "Ærø",
    "Bornholm",
    "Brønderslev",
    "Esbjerg",
    "Faaborg",
    "Flensborg",
    "Fredericia",
    "Frederikshavn",
    "Haderslev",
    "Helsingør",
    "Herning",
    "Hjørring",
    "Hobro",
    "Holbæk",
    "Holstebro",
    "Horsens",
    "Jyderup",
    "Kalundborg",
    "Kolding",
    "København",
    "Køge",
    "Lolland",
    "Malmø",
    "Middelfart",
    "Møns Klint",
    "Næstved",
    "Nyborg",
    "Nykøbing",
    "Odense",
    "Randers",
    "Ranum",
    "Ribe",
    "Ringkøbing",
    "Ringsted",
    "Roskilde",
    "Samsø",
    "Skagen",
    "Skælskør",
    "Slagelse",
    "Sønderborg",
    "Spodsbjerg",
    "Svendborg",
    "Thisted",
    "Tønder",
    "Varde",
    "Vejle",
    "Viborg",
  ];
  List<String> countryList;

  @override
  void initState() {
    setState(() {
      countryList = countries;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/imgs/bg.png'),fit: BoxFit.cover)
      ),
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imgs/list.png'),
                      fit: BoxFit.fitWidth),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextField(
                      style: GoogleFonts.cairo(color: Colors.white),
                      onChanged: (txt){
                        setState(() {
                          countryList=countries.where((element) => element.toLowerCase().contains(txt.toLowerCase())).toList(growable: true);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'search'.tr,
                        hintStyle: GoogleFonts.cairo(color: Colors.red),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()async{
                        await box.write('country', countryList[index]);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(country: countryList[index],)));
                      },
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/imgs/list.png'),
                              fit: BoxFit.fitWidth),
                        ),
                        child: Center(child: Text(countryList[index],style: GoogleFonts.cairo(color: Colors.white,fontSize: 14),)),
                      ),
                    );
                  },
                  itemCount: countryList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
