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
