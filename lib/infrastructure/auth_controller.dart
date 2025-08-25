import 'package:flutter/material.dart';
import 'package:novi_test/domain/repository/auth_repository.dart';
import 'package:novi_test/presentation/home/home_screen.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();
  String? token;

  Future<void> login(
    String countryCode,
    String phone,
    BuildContext context,
  ) async {
    token = await authRepository.login(countryCode, phone);
    notifyListeners();
    if (token != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Please check Mobile Number."),
          ),
        );
      }
    }
    notifyListeners();
  }
}
