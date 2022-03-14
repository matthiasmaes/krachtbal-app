import 'package:shared_preferences/shared_preferences.dart';

class LocalPersitance {
  Future<void> storeData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> readData(key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "No data found";
  }

  String getFavorite() {
    String local = "";
    LocalPersitance().readData('reeks').then((String result) => local = result);
    return local;
  }
}
