import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/data/models/match_model.dart';

class FirebaseAPI {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<String>?> getMatchList() async {
    try {
      final response = await _firestore.collection("football").get();
      return response.docs.map((e) => e.id).toList();
    } catch (e) {
      return null;
    }
  }

  static Future<MatchModel?> getMatchScore(String id) async {
    try {
      final response = await _firestore.collection("football").doc(id).get();
      if (response.exists == false || response.data() == null) return null;

      return MatchModel.fromJson(response.data()!);
    } catch (e) {
      return null;
    }
  }
}
