import 'package:flutter/material.dart';
import '../data/auth_repository.dart';
import '../domain/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel({required AuthRepository authRepository}) : _authRepository = authRepository;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    
    try {
      final result = await _authRepository.login(email, password);
      if (result != null) {
        _user = result;
        _setLoading(false);
        return true;
      } else {
        _errorMessage = "Credenciales inválidas";
      }
    } catch (e) {
      _errorMessage = "Error en la conexión";
    }
    
    _setLoading(false);
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    
    final result = await _authRepository.register(name, email, password);
    if (result != null) {
      _user = result;
      _setLoading(false);
      return true;
    }
    
    _setLoading(false);
    return false;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
