class HijriModel {
  String date;
  String format;
  String day;
  String dayname;
  String month;


  HijriModel({this.date, this.format, this.day, this.dayname,this.month});

  HijriModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    dayname = json['dayname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['format'] = this.format;
    data['day'] = this.day;
    data['dayname'] = this.dayname;
    return data;
  }
}