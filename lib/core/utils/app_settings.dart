import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:totowala/core/utils/app_const.dart';

class AppSettings{
  static final _box = Hive.box('myBox');
  static final storage = FlutterSecureStorage();


  // Save data
  static Future<void> saveData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  // Save access token data
  static Future<void> saveAccessToken( String value,{bool isRefresh=false}) async {
    await storage.write(key: isRefresh?AppConstant.kRefreshToken:AppConstant.kAccessToken, value: value);
  }

  // get access token data
  static Future<String?> getAccessToken({bool isRefresh=false}) async {
    String? value = await storage.read(key: isRefresh?AppConstant.kRefreshToken:AppConstant.kAccessToken);
    return value;
  }

  // Read data
  static dynamic getData(String key) {
    return _box.get(key);
  }

  // Update data
  static Future<void> updateData(String key, dynamic value) async {
    if (_box.containsKey(key)) {
      await _box.put(key, value);
    }
  }

  // Delete data
  static Future<void> deleteData(String key) async {
    await _box.delete(key);
  }

  // Clear all data
  static Future<void> clearAll() async {
    await _box.clear();
    await storage.deleteAll();
  }


}

