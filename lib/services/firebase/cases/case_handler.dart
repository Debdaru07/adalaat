import 'package:cloud_firestore/cloud_firestore.dart';
import '../../network/network_service.dart';
import '../../../constants/services/firebase_collections.dart';

class CaseHandler {
  final NetworkService _networkService;

  CaseHandler(this._networkService);

  // Create a new case
  Future<NetworkResponse<String>> createCase({
    required String caseId,
    required String title,
    required String status, // e.g., CaseStatuses.pending
    required List<String> parties,
  }) async {
    final data = {
      'caseId': caseId,
      'title': title,
      'status': status,
      'parties': parties,
      'dateFiled': FieldValue.serverTimestamp(),
    };
    return _networkService.createDocument(
      FirestoreCollections.cases,
      caseId,
      data,
    );
  }

  // Read a single case
  Future<NetworkResponse<Map<String, dynamic>>> getCase(String caseId) async {
    return _networkService.getDocument(
      FirestoreCollections.cases,
      caseId,
      (data) => data,
    );
  }

  // Read all cases
  Future<NetworkResponse<List<Map<String, dynamic>>>> getAllCases() async {
    return _networkService.getCollection(
      FirestoreCollections.cases,
      (data) => data,
    );
  }

  // Read cases with filter and sort
  Future<NetworkResponse<List<Map<String, dynamic>>>> getCases({
    String filter = '',
    String sortBy = 'dateFiled',
  }) async {
    try {
      Query<Map<String, dynamic>> query = _networkService.firestore
          .collection(FirestoreCollections.cases)
          .orderBy(sortBy, descending: true);

      if (filter.isNotEmpty) {
        query = query.where('status', isEqualTo: filter);
      }

      final snapshot = await query.get();
      final cases = snapshot.docs.map((doc) => doc.data()).toList();
      return NetworkResponse.success(cases, statusCode: 200);
    } catch (e) {
      return NetworkResponse.error('Failed to fetch cases: $e', 500);
    }
  }

  // Update case
  Future<NetworkResponse<void>> updateCase(
    String caseId, {
    String? title,
    String? status,
    List<String>? parties,
  }) async {
    Map<String, dynamic> updates = {};
    if (title != null) updates['title'] = title;
    if (status != null) updates['status'] = status;
    if (parties != null) updates['parties'] = parties;
    updates['lastUpdated'] = FieldValue.serverTimestamp();
    return _networkService.updateDocument(
      FirestoreCollections.cases,
      caseId,
      updates,
    );
  }

  // Delete case
  Future<NetworkResponse<void>> deleteCase(String caseId) async {
    return _networkService.deleteDocument(FirestoreCollections.cases, caseId);
  }
}
