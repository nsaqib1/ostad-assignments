import 'package:flutter/material.dart';

class MatchListItem extends StatelessWidget {
  const MatchListItem({
    super.key,
    required this.matchName,
    required this.onTap,
  });

  final String matchName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(matchName),
      trailing: const Icon(Icons.arrow_forward),
    );
  }
}
