import 'package:flutter/material.dart';
import 'package:novi_test/domain/model/category_model.dart';
import 'package:novi_test/domain/repository/app_repository.dart';
import 'package:novi_test/presentation/home/home_screen.dart';

class AppController extends ChangeNotifier {
  final AppRepository authRepository = AppRepository();
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

  List<CategoryModel> categoryList = [];
  bool isLoading = false;

  AppRepository appRepository = AppRepository();

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();
    categoryList = await appRepository.fetchCategories();
    isLoading = false;
    notifyListeners();
  }
}
