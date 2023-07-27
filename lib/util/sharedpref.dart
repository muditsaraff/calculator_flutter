import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  SharedPreferences? preferences;

  Future<void> saveFirstName(String firstname) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("firstName", firstname);
  }
}
