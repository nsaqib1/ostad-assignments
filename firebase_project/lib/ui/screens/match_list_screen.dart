import 'package:firebase_project/ui/screens/match_score_screen.dart';
import 'package:firebase_project/ui/widgets/match_list_item.dart';
import 'package:flutter/material.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  void _onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatchScoreScreen(matchId: "matchId"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match List"),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => MatchListItem(
          matchName: "matchName",
          onTap: _onTap,
        ),
      ),
    );
  }
}
