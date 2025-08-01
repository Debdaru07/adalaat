import 'package:flutter/material.dart';

import '../services/firebase/users/user_handler.dart';
import '../services/network/network_service.dart';

class AuthProviderVM with ChangeNotifier {
  final UserHandler _userHandler;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProviderVM(this._userHandler);

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
