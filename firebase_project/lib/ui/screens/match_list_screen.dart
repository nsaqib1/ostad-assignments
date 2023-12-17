import 'package:firebase_project/data/firebase/firebase_api.dart';
import 'package:firebase_project/ui/screens/match_score_screen.dart';
import 'package:firebase_project/ui/widgets/match_list_item.dart';
import 'package:flutter/material.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  bool _getMatchListInProgress = false;
  final List<String> _matchList = [];

  @override
  void initState() {
    super.initState();
    _getMatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match List"),
      ),
      body: Visibility(
        visible: _getMatchListInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: RefreshIndicator(
          onRefresh: _getMatchList,
          child: ListView.separated(
            itemCount: _matchList.length,
            itemBuilder: (context, index) => MatchListItem(
              matchName: _matchList[index],
              onTap: () {
                _onTap(_matchList[index]);
              },
            ),
            separatorBuilder: (_, __) => const Divider(),
          ),
        ),
      ),
    );
  }

  Future _getMatchList() async {
    _getMatchListInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final response = await FirebaseAPI.getMatchList();

    _getMatchListInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade900,
            content: const Text("Error! Could Not Load The Data."),
          ),
        );
      }
      return;
    }
    _matchList.clear();
    _matchList.addAll(response);
    if (mounted) {
      setState(() {});
    }
  }

  void _onTap(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchScoreScreen(matchId: id),
      ),
    );
  }
}
