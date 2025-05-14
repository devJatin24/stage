import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  final Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Map<String, dynamic>> networkCallGet(String _url) async {
    try {

      final response = await http.get(
        Uri.parse(_url),
        headers: defaultHeaders,
      ).timeout(Duration(seconds: 60));


      if (kDebugMode) {
        debugPrint("Response Body: ${response.body}");
      }


      if (response.statusCode == 200) {
        final resp =  json.decode(response.body);
        // Add "success": true to the response map
        resp['success'] = true;
        resp['status_message'] = "Success";
        return resp;
      } else {
        return json.decode(response.body);
      }
    } on http.ClientException catch (e) {
      debugPrint("HTTP Client Error: $e");
      return {
        'success': false,
        'status_message': 'Network request failed: ${e.message}',
        'error': e.toString(),
      };
    } catch (e) {
      debugPrint("error is $e");
      debugPrint("error is $e");
      return {"success": false, "status_message": e};
    }
  }
}
