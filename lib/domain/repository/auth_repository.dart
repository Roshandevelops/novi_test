import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthRepository {
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
}
