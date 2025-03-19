import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_guessing_game/models/leaderboard_entry.dart';
import 'package:word_guessing_game/screens/game.dart';
import 'package:word_guessing_game/screens/splash_screen.dart';
import 'package:word_guessing_game/services/api.dart';
import 'package:word_guessing_game/services/shared_prefs.dart';
import 'package:word_guessing_game/widgets/button.dart';

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
                    child: Center(child: Text('Your Score\n${userEntry!.name} :${userEntry.score}', style: GoogleFonts.roboto(fontSize: 18,), textAlign: TextAlign.center,))
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Leaderboard', style: GoogleFonts.roboto(fontSize: 20),),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          padding: EdgeInsets.all(10),
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          child: ListView.builder(
                            itemCount: leaderboard.length,
                            itemBuilder: (BuildContext context, int index){
                              return Column(
                                children: [
                                  Text('${index+1}. ${leaderboard[index].name} : ${leaderboard[index].score}', style: GoogleFonts.tektur(fontSize: 16),),
                                ],
                              );
                            }
                          ),
                        )
                      ],
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: BigButton(
                        onPressed: ()async{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(userScore: int.parse(userEntry.score), name: userEntry.name,)));
                        },
                        color: Colors.blue, 
                        child: Text('Play the Game', style: GoogleFonts.fontdinerSwanky(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),),

                      ),
                      
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: GeneralButton(
                        onPressed: (){
                          ApiService().deleteScore(userEntry.name);
                          SharedPrefs().clearData();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                        },
                        textColor: Colors.red, 
                        child: Text('Delete Account'),
                        // child: Text()
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