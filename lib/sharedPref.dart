import 'package:shared_preferences/shared_preferences.dart';

setStoreValue(String country) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('Country', country);
}

Future<String> getStoreValue(String key) async =>
    (await SharedPreferences.getInstance()).getString(key);
