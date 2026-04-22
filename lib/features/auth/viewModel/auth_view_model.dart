import 'package:flutter/material.dart';
import 'package:inventory_management/core/services/api_service.dart';
import 'package:inventory_management/core/services/auth_service.dart';
import 'package:inventory_management/logger.dart';

class AuthViewModel extends ChangeNotifier {
  final Authservice service;
  final Apiservice api;

  AuthViewModel(this.service, this.api);

  bool isLoading = false;
  String? error;
  String? token;

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      token = await service.login(email, password);
      api.token = token;

      return true;
    } catch (e) {
      error = e.toString();
      logger.e(error);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}