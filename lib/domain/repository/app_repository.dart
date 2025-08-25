import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:novi_test/domain/model/category_model.dart';
import 'package:novi_test/domain/model/feed_model.dart';

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
        final token = jsonResponse['token']["access"];

        return token;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse("https://frijo.noviindus.in/api/category_list"));
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

  Future<List<FeedModel>> fetchHomeFeedData() async {
    try {
      final response =
          await http.get(Uri.parse("https://frijo.noviindus.in/api/home"));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final body = jsonDecode(response.body);
        final result = (body["results"] as List).map(
          (e) {
            return FeedModel.fromJson(e);
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

  Future<bool> uploadFeed({
    required String token,
    required String desc,
    required List<int> categories,
    required File video,
    required File image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://frijo.noviindus.in/api/my_feed"),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['desc'] = desc;
      request.fields['category'] = categories.toString();
      request.files.add(await http.MultipartFile.fromPath('video', video.path));
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      final response = await request.send();

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }
}
