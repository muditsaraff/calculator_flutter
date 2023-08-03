import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  SharedPreferences? preferences;

  Future<void> saveFirstName(String firstname) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("firstName", firstname);
  }

  Future<void> saveLastName(String lastname) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("lastName", lastname);
  }

  Future<void> saveEmail(String email) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("email", email);
  }

  Future<void> saveid(int id) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setInt("id", id);
  }

  Future<void> saveGender(String gender) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("gender", gender);
  }

  Future<void> saveImage(String image) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("image", image);
  }

  Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }
}
