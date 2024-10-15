class PrayerTimeModel {
  String? city;
  String? dateFor;
  String? fajr;
  String? shurooq;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;

  PrayerTimeModel({
    this.city,
    this.dateFor,
    this.fajr,
    this.shurooq,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
  });

  factory PrayerTimeModel.fromDateFor202472Fajr350AmShurooq524AmDhuhr1220PmAsr344PmMaghrib715PmIsha845Pm(
      Map<String, dynamic> json) {
    return PrayerTimeModel(
      city: json['city'] as String?,
      dateFor: json['items'][0]['date_for'] as String?,
      fajr: json['items'][0]['fajr'] as String?,
      shurooq: json['items'][0]['shurooq'] as String?,
      dhuhr: json['items'][0]['dhuhr'] as String?,
      asr: json['items'][0]['asr'] as String?,
      maghrib: json['items'][0]['maghrib'] as String?,
      isha: json['items'][0]['isha'] as String?,
    );
  }

  Map<String, dynamic>
      toDateFor202472Fajr350AmShurooq524AmDhuhr1220PmAsr344PmMaghrib715PmIsha845Pm() {
    return {
      'date_for': dateFor,
      'fajr': fajr,
      'shurooq': shurooq,
      'dhuhr': dhuhr,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
    };
  }
}
