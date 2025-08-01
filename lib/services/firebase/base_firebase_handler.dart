import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirebaseHandler {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get Firestore instance
  FirebaseFirestore get firestore => _firestore;

  // Get FirebaseAuth instance
  FirebaseAuth get auth => _auth;

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Handle Firebase errors
  String handleError(dynamic error) {
    return error.toString();
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Sign-out error: ${handleError(e)}');
    }
  }
}
