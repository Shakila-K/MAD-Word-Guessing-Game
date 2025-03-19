class LeaderboardEntry {
  
  final String name;
  final String score;

  LeaderboardEntry({
    required this.name,
    required this.score
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic>json){
    return LeaderboardEntry(
      name: json['name'], 
      score: json['score']
    );
  }
  
}