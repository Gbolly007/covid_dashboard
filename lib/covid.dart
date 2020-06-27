import 'networking.dart';

class CovidModel {
  Future<dynamic> getCovidata() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.covid19api.com/summary');

    var coviData = await networkHelper.getData();
    print(coviData);
    return coviData;
  }

  Future<dynamic> getCovidChart(String slug) async {
    var now = DateTime.now();
    now = now.toUtc();
    now = now.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
      microseconds: now.microsecond,
    ));
    String n = now.toString();
    n = n.substring(0, 10) + "T" + n.substring(11);
    var anotherDt = now.subtract(Duration(days: 30, hours: 00));
    anotherDt = anotherDt.toUtc();
    String p = anotherDt.toString();
    p = p.substring(0, 10) + "T" + p.substring(11);
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.covid19api.com/country/$slug/status/confirmed?from=$p&to=$n');

    var coviData = await networkHelper.getData();
    print(coviData);
    return coviData;
  }
}
