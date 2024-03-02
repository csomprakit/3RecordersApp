import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Leaderboard Page',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        actions: [
          IconButton( icon: Icon(Icons.refresh), onPressed: () {})
        ],
      ),
      body: const Column(
        children: [
          Text("Dedication Level"),
          SizedBox(height: 15),
          Text("Last Input"),
          SizedBox(height: 15),
          Text("Category"),
          SizedBox(height: 15),
          Text("Time"),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
