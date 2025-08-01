import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase/base_firebase_handler.dart';

enum ApiState { idle, loading, success, error }

class NetworkResponse<T> {
  final ApiState state;
  final T? data;
  final String? error;
  final int statusCode;

  NetworkResponse({
    required this.state,
    this.data,
    this.error,
    required this.statusCode,
  });

  factory NetworkResponse.success(T data, {int statusCode = 200}) {
    return NetworkResponse(
      state: ApiState.success,
      data: data,
      statusCode: statusCode,
    );
  }

  factory NetworkResponse.error(String error, int statusCode) {
    return NetworkResponse(
      state: ApiState.error,
      error: error,
      statusCode: statusCode,
    );
  }

  factory NetworkResponse.loading() {
    return NetworkResponse(state: ApiState.loading, statusCode: 0);
  }
}

class NetworkService extends BaseFirebaseHandler {
  // Map Firebase exceptions to HTTP status codes
  int _mapFirebaseErrorToStatusCode(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
        case 'invalid-credential':
          return 400; // Bad Request
        case 'user-not-found':
        case 'wrong-password':
          return 401; // Unauthorized
        case 'email-already-in-use':
          return 409; // Conflict
        case 'operation-not-allowed':
          return 403; // Forbidden
        default:
          return 500; // Internal Server Error
      }
    } else if (error is FirebaseException) {
      switch (error.code) {
        case 'not-found':
          return 404; // Not Found
        case 'permission-denied':
          return 403; // Forbidden
        default:
          return 500; // Internal Server Error
      }
    }
    return 500; // Default to Internal Server Error
  }

  // Common method handler for Firestore GET operations
  Future<NetworkResponse<T>> getDocument<T>(
    String collection,
    String documentId,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final doc = await firestore.collection(collection).doc(documentId).get();
      if (!doc.exists) {
        return NetworkResponse.error('Document not found', 404);
      }
      final data = fromJson(doc.data() as Map<String, dynamic>);
      return NetworkResponse.success(data, statusCode: 200);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }

  // Common method handler for Firestore GET collection
  Future<NetworkResponse<List<T>>> getCollection<T>(
    String collection,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final query = await firestore.collection(collection).get();
      final data = query.docs.map((doc) => fromJson(doc.data())).toList();
      return NetworkResponse.success(data, statusCode: 200);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }

  // Common method handler for Firestore CREATE
  Future<NetworkResponse<String>> createDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await firestore.collection(collection).doc(documentId).set(data);
      return NetworkResponse.success(documentId, statusCode: 201);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }

  // Common method handler for Firestore UPDATE
  Future<NetworkResponse<void>> updateDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await firestore.collection(collection).doc(documentId).update(data);
      return NetworkResponse.success(null, statusCode: 200);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }

  // Common method handler for Firestore DELETE
  Future<NetworkResponse<void>> deleteDocument(
    String collection,
    String documentId,
  ) async {
    try {
      await firestore.collection(collection).doc(documentId).delete();
      return NetworkResponse.success(null, statusCode: 200);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }

  // Common method handler for Firebase Authentication (Sign In)
  Future<NetworkResponse<User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse.success(userCredential.user!, statusCode: 200);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }

  // Common method handler for Firebase Authentication (Sign Up)
  Future<NetworkResponse<User>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      await user.updateDisplayName(fullName);
      return NetworkResponse.success(user, statusCode: 201);
    } catch (e) {
      final statusCode = _mapFirebaseErrorToStatusCode(e);
      return NetworkResponse.error(handleError(e), statusCode);
    }
  }
}
