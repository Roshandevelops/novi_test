import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novi_test/domain/model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryController extends ChangeNotifier {
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(""));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final body = jsonDecode(response.body);
        final result = (body["categories"] as List).map(
          (e) {
            return CategoryModel.fromJson(e);
          },
        ).toList();
        return result;
      } else {
        return [];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
