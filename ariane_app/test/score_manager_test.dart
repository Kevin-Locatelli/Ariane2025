import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/utils/score_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  group('ScoreManager', () {
    setUp(() {
      // Mock SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() async {
      // Clear SharedPreferences after each test
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    test('saveScore saves a score correctly', () async {
      await ScoreManager.saveScore(
        gameName: 'TestGame',
        score: 100,
        message: 'Well done!',
      );

      final prefs = await SharedPreferences.getInstance();
      final scoresJson = prefs.getStringList('game_scores');

      expect(scoresJson, isNotNull);
      expect(scoresJson!.length, 1);

      final savedScore = jsonDecode(scoresJson[0]) as Map<String, dynamic>;
      expect(savedScore['gameName'], 'TestGame');
      expect(savedScore['score'], 100);
      expect(savedScore['message'], 'Well done!');
      expect(savedScore.containsKey('timestamp'), isTrue);
    });

    test('loadScores loads multiple scores correctly', () async {
      final prefs = await SharedPreferences.getInstance();
      final List<String> initialScores = [
        jsonEncode({
          'gameName': 'Game1',
          'score': 50,
          'message': 'Good attempt',
          'timestamp': DateTime.now().toIso8601String(),
        }),
        jsonEncode({
          'gameName': 'Game2',
          'score': 150,
          'message': 'Excellent!',
          'timestamp': DateTime.now().toIso8601String(),
        }),
      ];
      await prefs.setStringList('game_scores', initialScores);

      final loadedScores = await ScoreManager.loadScores();

      expect(loadedScores.length, 2);
      expect(loadedScores[0]['gameName'], 'Game1');
      expect(loadedScores[1]['score'], 150);
    });

    test('clearScores removes all saved scores', () async {
      await ScoreManager.saveScore(
        gameName: 'GameToClear',
        score: 200,
        message: 'Temporary score',
      );

      final prefsBeforeClear = await SharedPreferences.getInstance();
      expect(prefsBeforeClear.getStringList('game_scores'), isNotEmpty);

      await ScoreManager.clearScores();

      final prefsAfterClear = await SharedPreferences.getInstance();
      expect(prefsAfterClear.getStringList('game_scores'), isNull);
    });

    test('loadScores returns empty list if no scores are saved', () async {
      final loadedScores = await ScoreManager.loadScores();
      expect(loadedScores, isEmpty);
    });
  });
}
