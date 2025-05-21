import 'package:hive/hive.dart';

class AppSettings{
  static final _box = Hive.box('myBox');

  // Save data
  static Future<void> saveData(String key, dynamic value) async {
    await _box.put(key, value);
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
  }
}