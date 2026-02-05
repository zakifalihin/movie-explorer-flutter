import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String key = 'favorites';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<bool> isFavorite(String id) async {
    final favs = await getFavorites();
    return favs.contains(id);
  }

  static Future<void> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(key) ?? [];

    if (favs.contains(id)) {
      favs.remove(id);
    } else {
      favs.add(id);
    }

    await prefs.setStringList(key, favs);
  }
}
