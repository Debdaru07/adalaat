import 'package:cloud_firestore/cloud_firestore.dart';

import '../base_firebase_handler.dart';
import '../../../constants/firebase_collections.dart';

class CaseHandler extends BaseFirebaseHandler {
  // Create a new case
  Future<void> createCase({
    required String caseId,
    required String title,
    required String status, // e.g., CaseStatuses.pending
    required List<String> parties,
  }) async {
    try {
      await firestore.collection(FirestoreCollections.cases).doc(caseId).set({
        'caseId': caseId,
        'title': title,
        'status': status,
        'parties': parties,
        'dateFiled': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error creating case: ${handleError(e)}');
    }
  }

  // Read a single case
  Future<Map<String, dynamic>?> getCase(String caseId) async {
    try {
      DocumentSnapshot doc =
          await firestore
              .collection(FirestoreCollections.cases)
              .doc(caseId)
              .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Error fetching case: ${handleError(e)}');
    }
  }

  // Read all cases
  Future<List<Map<String, dynamic>>> getAllCases() async {
    try {
      QuerySnapshot query =
          await firestore.collection(FirestoreCollections.cases).get();
      return query.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error fetching cases: ${handleError(e)}');
    }
  }

  // Update case
  Future<void> updateCase(
    String caseId, {
    String? title,
    String? status,
    List<String>? parties,
  }) async {
    try {
      Map<String, dynamic> updates = {};
      if (title != null) updates['title'] = title;
      if (status != null) updates['status'] = status;
      if (parties != null) updates['parties'] = parties;
      updates['lastUpdated'] = FieldValue.serverTimestamp();
      await firestore
          .collection(FirestoreCollections.cases)
          .doc(caseId)
          .update(updates);
    } catch (e) {
      throw Exception('Error updating case: ${handleError(e)}');
    }
  }

  // Delete case
  Future<void> deleteCase(String caseId) async {
    try {
      await firestore
          .collection(FirestoreCollections.cases)
          .doc(caseId)
          .delete();
    } catch (e) {
      throw Exception('Error deleting case: ${handleError(e)}');
    }
  }
}
