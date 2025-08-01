import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants/user_account_status.dart';
import '../base_firebase_handler.dart';
import '../../../constants/firebase_collections.dart';

class UserHandler extends BaseFirebaseHandler {
  // Sign up with email, password, and additional user details
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role, // e.g., UserRoles.judge
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Update user profile
        await user.updateDisplayName(fullName);
        // Store user data in Firestore
        await firestore
            .collection(FirestoreCollections.users)
            .doc(user.uid)
            .set({
              'email': email,
              'fullName': fullName,
              'role': role,
              'accountStatus': UserAccountStatuses.active,
              'createdAt': FieldValue.serverTimestamp(),
            });
        // Note: Set custom claims for role via Firebase Admin SDK on backend
      }
      return user;
    } catch (e) {
      throw Exception('Sign-up error: ${handleError(e)}');
    }
  }

  // Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Sign-in error: ${handleError(e)}');
    }
  }

  // Read user data
  Future<Map<String, dynamic>?> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection(FirestoreCollections.users).doc(uid).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Error fetching user: ${handleError(e)}');
    }
  }

  // Update user data
  Future<void> updateUser(
    String uid, {
    String? fullName,
    String? role,
    String? accountStatus,
  }) async {
    try {
      Map<String, dynamic> updates = {};
      if (fullName != null) updates['fullName'] = fullName;
      if (role != null) updates['role'] = role;
      if (accountStatus != null) updates['accountStatus'] = accountStatus;
      updates['lastUpdated'] = FieldValue.serverTimestamp();
      await firestore
          .collection(FirestoreCollections.users)
          .doc(uid)
          .update(updates);
      if (fullName != null) {
        await auth.currentUser?.updateDisplayName(fullName);
      }
    } catch (e) {
      throw Exception('Error updating user: ${handleError(e)}');
    }
  }

  // Delete user
  Future<void> deleteUser(String uid) async {
    try {
      await firestore.collection(FirestoreCollections.users).doc(uid).delete();
      await auth.currentUser?.delete(); // Note: Requires re-authentication
    } catch (e) {
      throw Exception('Error deleting user: ${handleError(e)}');
    }
  }
}
