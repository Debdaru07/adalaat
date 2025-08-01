import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/services/user_account_status.dart';
import '../../constants/services/firebase_collections.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email, password, and additional user details
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role, // e.g., UserRoles.judge
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        // Update user profile
        await user.updateDisplayName(fullName);
        // Store additional user data in Firestore
        await _firestore
            .collection(FirestoreCollections.users)
            .doc(user.uid)
            .set({
              'email': email,
              'fullName': fullName,
              'role': role,
              'accountStatus': UserAccountStatuses.active,
              'createdAt': FieldValue.serverTimestamp(),
            });
        // Set custom claim for role (requires Firebase Admin SDK on backend)
        // Example: await setCustomUserClaims(user.uid, {'role': role});
      }
      return user;
    } catch (e) {
      print('Sign-up error: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign-in error: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Fetch user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore
              .collection(FirestoreCollections.users)
              .doc(uid)
              .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
