import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}


class _LeaderboardPageState extends State<LeaderboardPage> {
  //String _dedicationLevel = "Loading...";
  //String _totalPoints = "Loading...";
  List<String> _leaderboard = [];

  @override
  void initState() {
    super.initState();
    //getDedicationLevel();
    getLeaderboard();
  }
/***
  Future<void> getDedicationLevel() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collection = db.collection('sharedcount');
    QuerySnapshot snapshot = await collection.get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot document = snapshot.docs.first;
      int dedicationLevel = document['dedicationLevel'];
      int totalPoints = document['totalPoints'];
      print("get dedication");
      print(dedicationLevel);
      print("get totalpoint");
      print(totalPoints);
      setState(() {
        _dedicationLevel = dedicationLevel.toString();
        _totalPoints = totalPoints.toString();
      });
    } else {
      print('No documents found in sharedcount');
    }
  }
***/

  Future<void> getLeaderboard() async {
      String userId = FirebaseAuth.instance.currentUser?.email ?? '';
      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference collection = db.collection('sharedcount');
      QuerySnapshot snapshot = await collection.orderBy('totalPoints', descending: true).get();
      List<String> leaderboard = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        int points = doc['totalPoints'];
        print('$userId: $points points');
        leaderboard.add('$userId: $points points');
      }
      setState(() {
        _leaderboard = leaderboard;
      });
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
          IconButton( icon: Icon(Icons.refresh), onPressed: () {
          getLeaderboard();
        }),
        ],
      ),
      body: ListView.builder(
        itemCount: _leaderboard.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_leaderboard[index]),
          );
        },
      )
    );
  }
}
