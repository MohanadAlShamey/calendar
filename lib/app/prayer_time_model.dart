class PrayerTimeModel {
  int id;
  String country;
  String today;
  String imsak;
  String fajr;
  String shuroq;
  String dhuhr;
  String asr;
  String magrib;
  String isha;
  String createdAt;
  String updatedAt;

  PrayerTimeModel(
      {this.id,
        this.country,
        this.today,
        this.imsak,
        this.fajr,
        this.shuroq,
        this.dhuhr,
        this.asr,
        this.magrib,
        this.isha,
        this.createdAt,
        this.updatedAt});

  PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    today = json['today'];
    imsak = json['imsak'];
    fajr = json['fajr'];
    shuroq = json['shuroq'];
    dhuhr = json['dhuhr'];
    asr = json['asr'];
    magrib = json['magrib'];
    isha = json['isha'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['today'] = this.today;
    data['imsak'] = this.imsak;
    data['fajr'] = this.fajr;
    data['shuroq'] = this.shuroq;
    data['dhuhr'] = this.dhuhr;
    data['asr'] = this.asr;
    data['magrib'] = this.magrib;
    data['isha'] = this.isha;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}