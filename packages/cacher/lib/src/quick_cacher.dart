import 'package:cacher/src/cacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuickCacher extends Cacher {
  const QuickCacher({required this.storage});

  final SharedPreferences storage;

  @override
  String? get(String key) {
    return storage.getString(key);
  }

  @override
  Future<void> set(String key, String? value) async {
    if (value == null) {
      await storage.remove(key);
    } else {
      await storage.setString(key, value);
    }
  }
}
