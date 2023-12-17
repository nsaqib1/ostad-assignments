import 'package:firebase_project/data/models/match_model.dart';
import 'package:flutter/material.dart';

class MatchScoreCard extends StatelessWidget {
  const MatchScoreCard({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            matchModel.matchName,
            style: TextStyle(fontSize: 28, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 5),
          Text(
            matchModel.goals,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Time: ${matchModel.elapsedTime}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 5),
          Text(
            "Total Time: ${matchModel.totalTime}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
