class MatchModel {
  final String matchName;
  final String goals;
  final String elapsedTime;
  final String totalTime;

  MatchModel({
    required this.matchName,
    required this.goals,
    required this.elapsedTime,
    required this.totalTime,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchName: json["matchName"] ?? "Not Found",
      goals: json["goals"] ?? "Not Found",
      elapsedTime: json["elapsedTime"] ?? "Not Found",
      totalTime: json["totalTime"] ?? "Not Found",
    );
  }
}
