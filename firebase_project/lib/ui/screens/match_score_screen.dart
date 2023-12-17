import 'package:firebase_project/data/models/match_model.dart';
import 'package:firebase_project/ui/widgets/match_scrore_card.dart';
import 'package:flutter/material.dart';

class MatchScoreScreen extends StatefulWidget {
  const MatchScoreScreen({super.key, required this.matchId});

  final String matchId;

  @override
  State<MatchScoreScreen> createState() => _MatchScoreScreenState();
}

class _MatchScoreScreenState extends State<MatchScoreScreen> {
  late final MatchModel _matchModel;
  @override
  void initState() {
    super.initState();
    _matchModel = MatchModel(
      matchName: "matchName",
      goals: "2 : 3",
      elapsedTime: "67:32",
      totalTime: "90:00",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MatchScoreCard(matchModel: _matchModel),
          ],
        ),
      ),
    );
  }
}
