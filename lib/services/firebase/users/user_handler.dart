import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants/services/user_account_status.dart';
import '../../network/network_service.dart';
import '../../../constants/services/firebase_collections.dart';

class UserHandler {
  final NetworkService _networkService;

  UserHandler(this._networkService);

  // Expose FirebaseAuth instance
  FirebaseAuth get auth => _networkService.auth;

  // Sign up with email, password, and additional user details
  Future<NetworkResponse<User>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role, // e.g., UserRoles.judge
  }) async {
    try {
      final response = await _networkService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      if (response.state == ApiState.success && response.data != null) {
        // Store user data in Firestore
        final userData = {
          'email': email,
          'fullName': fullName,
          'role': role,
          'accountStatus': UserAccountStatuses.active,
          'createdAt': FieldValue.serverTimestamp(),
        };
        final storeResponse = await _networkService.createDocument(
          FirestoreCollections.users,
          response.data!.uid,
          userData,
        );
        if (storeResponse.state == ApiState.success) {
          return response;
        }
        return NetworkResponse.error(
          storeResponse.error ?? 'Failed to store user data',
          storeResponse.statusCode,
        );
      }
      return response;
    } catch (e) {
      return NetworkResponse.error('Sign-up error: $e', 500);
    }
  }

  // Sign in with email and password
  Future<NetworkResponse<User>> signIn({
    required String email,
    required String password,
  }) async {
    return _networkService.signIn(email: email, password: password);
  }

  // Read user data
  Future<NetworkResponse<Map<String, dynamic>>> getUser(String uid) async {
    return _networkService.getDocument(
      FirestoreCollections.users,
      uid,
      (data) => data,
    );
  }

  // Update user data
  Future<NetworkResponse<void>> updateUser(
    String uid, {
    String? fullName,
    String? role,
    String? accountStatus,
  }) async {
    Map<String, dynamic> updates = {};
    if (fullName != null) updates['fullName'] = fullName;
    if (role != null) updates['role'] = role;
    if (accountStatus != null) updates['accountStatus'] = accountStatus;
    updates['lastUpdated'] = FieldValue.serverTimestamp();
    final response = await _networkService.updateDocument(
      FirestoreCollections.users,
      uid,
      updates,
    );
    if (response.state == ApiState.success && fullName != null) {
      await _networkService.auth.currentUser?.updateDisplayName(fullName);
    }
    return response;
  }

  // Delete user
  Future<NetworkResponse<void>> deleteUser(String uid) async {
    final response = await _networkService.deleteDocument(
      FirestoreCollections.users,
      uid,
    );
    if (response.state == ApiState.success) {
      await _networkService.auth.currentUser
          ?.delete(); // Requires re-authentication
    }
    return response;
  }

  // Sign out
  Future<NetworkResponse<void>> signOut() async {
    try {
      await _networkService.signOut();
      return NetworkResponse.success(null, statusCode: 200);
    } catch (e) {
      return NetworkResponse.error('Sign-out error: $e', 500);
    }
  }
}
