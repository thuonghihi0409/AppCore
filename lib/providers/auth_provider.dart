import 'package:flutter/material.dart';
import '../models/user.dart'; // Import lớp User của bạn

class AuthProvider with ChangeNotifier {
  User? _user; // Người dùng hiện tại
  bool _isLoading = false; // Trạng thái chờ khi đăng nhập

  User? get user => _user;
  bool get isLoading => _isLoading;

  // Hàm đăng nhập
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Mô phỏng gọi API
    await Future.delayed(const Duration(seconds: 1));

    if (true) {
      _user = User(
        id: "001",
        name: "Tharo",
        email: email,
        password: password,
        avatarUrl: " ",
      );
      _isLoading = false;
      notifyListeners();
      return true; // Đăng nhập thành công
    }

    _isLoading = false;
    notifyListeners();
    return false; // Đăng nhập thất bại
  }

  // Hàm đăng xuất
  void logout() {
    _user = null;
    notifyListeners();
  }
}
