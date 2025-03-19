import 'package:flutter/material.dart';
import 'package:word_guessing_game/models/leaderboard_entry.dart';
import 'package:word_guessing_game/screens/game.dart';
import 'package:word_guessing_game/screens/splash_screen.dart';
import 'package:word_guessing_game/services/api.dart';
import 'package:word_guessing_game/services/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  LeaderboardEntry? getEntryByUsername(List<LeaderboardEntry> leaderboard, String username) {
    try {
      return leaderboard.firstWhere((entry) => entry.name == username);
    } catch (e) {
      return null; // Return null if username is not found
    }
  }

  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<LeaderboardEntry>?>(
          future: ApiService().getLeaderboard(), 
          builder: (BuildContext context, AsyncSnapshot<List<LeaderboardEntry>?> snapshot){
            if(snapshot.hasData){
              List<LeaderboardEntry> leaderboard = snapshot.data!;
              LeaderboardEntry? userEntry = getEntryByUsername(leaderboard, "${SharedPrefs().getStringValue('name')}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text('Your Score\n${userEntry!.name} :${userEntry.score}'))
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Leaderboard'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                            child: ListView.builder(
                              itemCount: leaderboard.length,
                              itemBuilder: (BuildContext context, int index){
                                return Column(
                                  children: [
                                    Text('Name: ${leaderboard[index].name}'),
                                    Text('Score: ${leaderboard[index].score}')
                                  ],
                                );
                              }
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: ()async{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(userScore: int.parse(userEntry.score), name: userEntry.name,)));
                        }, 
                        child: Text('Play')
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: (){
                          ApiService().deleteScore(userEntry.name);
                          SharedPrefs().clearData();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                        }, 
                        child: Text('Delete Account')
                      ),
                    ),
                  )
                ],
              );
            } else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        )
      ),
    );
  }
}