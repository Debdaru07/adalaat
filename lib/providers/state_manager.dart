import 'package:flutter/material.dart';
import '../services/firebase/cases/case_handler.dart';
import '../services/firebase/users/user_handler.dart';
import '../services/network/network_service.dart';

class AuthProvider with ChangeNotifier {
  final UserHandler _userHandler;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._userHandler);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final response = await _userHandler.signIn(
      email: email,
      password: password,
    );
    _isLoading = false;
    if (response.state == ApiState.error) {
      _errorMessage = response.error;
    }
    notifyListeners();
  }

  Future<void> signUp(
    String email,
    String password,
    String fullName,
    String role,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final response = await _userHandler.signUp(
      email: email,
      password: password,
      fullName: fullName,
      role: role,
    );
    _isLoading = false;
    if (response.state == ApiState.error) {
      _errorMessage = response.error;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    await _userHandler.signOut();
    _isLoading = false;
    notifyListeners();
  }
}

class CaseProvider with ChangeNotifier {
  final CaseHandler _caseHandler;
  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _cases = [];
  String _filter = '';
  String _sortBy = 'Date Filed';

  CaseProvider(this._caseHandler);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get cases => _cases;

  Future<void> fetchCases() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final response = await _caseHandler.getCases(
      filter: _filter,
      sortBy: _sortBy,
    );
    _isLoading = false;
    if (response.state == ApiState.success) {
      _cases = response.data as List<Map<String, dynamic>>;
    } else {
      _errorMessage = response.error;
    }
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    fetchCases();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    fetchCases();
  }
}
