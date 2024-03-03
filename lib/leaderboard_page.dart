import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beamer/beamer.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}


class _LeaderboardPageState extends State<LeaderboardPage> {
  List<String> _leaderboard = [];

  @override
  void initState() {
    super.initState();
    getLeaderboard();
  }

  Future<void> getLeaderboard() async {
    List<String> leaderboard = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collection = db.collection('sharedcount');
    QuerySnapshot snapshot = await collection.orderBy('totalPoints', descending: true).get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      int points = doc['totalPoints'];
      String email = doc['email'].toString();
      leaderboard.add('$email: $points points');
    }
    setState(() {
      _leaderboard = leaderboard;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Beamer.of(context).beamToNamed('/user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            'Leaderboard Page',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {
          getLeaderboard();
        }),
          IconButton(icon: const Icon(Icons.logout), onPressed: () {
            _logout();
          }),
        ],
      ),
      body: Column(
        children: [
            const Text(
              'Leaderboard',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _leaderboard.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_leaderboard[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
