import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:word_guessing_game/models/leaderboard_entry.dart';

class ApiService{

  String leaderboardUrl = 'http://dreamlo.com/lb/x5rVAX_430yaRSJPZ_7B1Ausuar_rP3Eme1pqR-iQfUw';

  Future<List<LeaderboardEntry>?> getLeaderboard() async {
    try {
      Response response = await Dio().get('$leaderboardUrl/json/10');
      if (response.statusCode == 200) {
        List<LeaderboardEntry> leaderboard = [];

        var entries = response.data['dreamlo']['leaderboard']['entry'];

        if (entries != null) {
          if (entries is List) {
            for (var entry in entries) {
              leaderboard.add(LeaderboardEntry.fromJson(entry as Map<String, dynamic>));
            }
          } else if (entries is Map) {
            leaderboard.add(LeaderboardEntry.fromJson(entries.cast<String, dynamic>()));
          }
        }
        return leaderboard;
      } else {
        return null;
      }
    } on DioException {
      return null;
    }
  }



  Future<bool> addScore(String name, int score) async{
    try{
      Response response = await Dio().get('$leaderboardUrl/add/$name/$score');
      if(response.statusCode == 200){
        return true;
      }
    } on DioException {
      return false;
    }
    return false;
  }

  Future<void> deleteScore(String name) async{
    try{
      Response response = await Dio().get('$leaderboardUrl/delete/$name');
      print(response.statusCode);
      print(response.data);
    } on DioException catch(e){
      print(e);
    }
  }

  Future<String?> getRandomWord() async{
    try{
      Response response = await Dio().get('https://api.api-ninjas.com/v1/randomword', 
        options: Options(
          headers: {
            "X-Api-Key" : "${dotenv.env['X-Api-Key']}"
          }
        )
      );
      if(response.statusCode == 200){
        print(response.data['word'][0]);
        return response.data['word'][0];
      }
    } on DioException {
      return null;
    }
    return null;
  }

  Future<List<String>?> getSimilarWord(String word) async{
    try{
      Response response = await Dio().get('https://api.api-ninjas.com/v1/thesaurus?word=$word', 
        options: Options(
          headers: {
            "X-Api-Key" : "${dotenv.env['X-Api-Key']}"
          }
        )
      );
      print(response.data);
      if(response.statusCode == 200){
        List<String> synonyms = List<String>.from(response.data['synonyms']);
        return synonyms.take(5).toList();
      }
    } on DioException {
      return null;
    }
    return null;
  }

  Future<List<String>?> getRhymingWord(String word) async{
    try{
      Response response = await Dio().get('https://api.api-ninjas.com/v1/rhyme?word=$word', 
        options: Options(
          headers: {
            "X-Api-Key" : "${dotenv.env['X-Api-Key']}"
          }
        )
      );
      print(response.data);
      if(response.statusCode == 200){
        List<String> synonyms = List<String>.from(response.data);
        return synonyms.take(5).toList();
      }
    } on DioException {
      return null;
    }
    return null;
  }

}