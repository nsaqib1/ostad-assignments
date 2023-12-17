import 'package:firebase_project/data/firebase/firebase_api.dart';
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
  bool _getMatchScoreInProgress = false;
  MatchModel? _matchModel;

  @override
  void initState() {
    super.initState();
    _getMatchScore(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchId),
      ),
      body: Visibility(
        visible: _getMatchScoreInProgress == false,
        replacement: const LinearProgressIndicator(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _matchModel == null ? const SizedBox.shrink() : MatchScoreCard(matchModel: _matchModel!),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getMatchScore(String id) async {
    _getMatchScoreInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final response = await FirebaseAPI.getMatchScore(id);

    _getMatchScoreInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade900,
            content: const Text("Error! Could Not Load Data. Check Your Network Connection And Try Again!"),
          ),
        );
      }
      return;
    }

    _matchModel = response;
    if (mounted) {
      setState(() {});
    }
  }
}
