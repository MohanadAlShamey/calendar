class CountryModel {
  String country;
  List<String> cities;

  CountryModel({this.country, this.cities});

  CountryModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country.toLowerCase();
    data['cities'] = this.cities;
    return data;
  }
}