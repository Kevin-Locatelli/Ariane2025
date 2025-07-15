import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ScoreManager {
  static const String _scoresKey = 'game_scores';

  static Future<void> saveScore({
    required String gameName,
    required int score,
    required String message,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoresJson = prefs.getStringList(_scoresKey) ?? [];

    Map<String, dynamic> newScore = {
      'gameName': gameName,
      'score': score,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    };

    scoresJson.add(jsonEncode(newScore));
    await prefs.setStringList(_scoresKey, scoresJson);
  }

  static Future<List<Map<String, dynamic>>> loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoresJson = prefs.getStringList(_scoresKey) ?? [];

    return scoresJson.map((score) => jsonDecode(score) as Map<String, dynamic>).toList();
  }

  static Future<void> clearScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scoresKey);
  }
}