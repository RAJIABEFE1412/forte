import 'package:shared_preferences/shared_preferences.dart';


Future<String> getAnyFromSharedPref(String name) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  return sharedPref.getString(name);
}

void setAnyinSharedPref(String val, String name) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString(name, val);
}
