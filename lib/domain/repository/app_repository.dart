import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:novi_test/domain/model/category_model.dart';

class AppRepository {
  Future<String?> login(String countryCode, String phone) async {
    try {
      final url = Uri.parse("https://frijo.noviindus.in/api/otp_verified");

      var request = http.MultipartRequest('POST', url);
      request.fields['country_code'] = countryCode;
      request.fields['phone'] = phone;

      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode >= 200 &&
          streamedResponse.statusCode <= 299) {
        final jsonResponse = jsonDecode(responseString);
        log(jsonResponse.toString());
        final token = jsonResponse['token']["refresh"];

        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse("https://frijo.noviindus.in/api/category_list"));
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
