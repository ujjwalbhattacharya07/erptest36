import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceEditAsset {
  final String baseUrl = 'http://192.168.1.106:8082/assetsapi';

  Future<bool> editAsset(Map<String, dynamic> assetData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/editasset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(assetData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      throw Exception('Failed to edit asset');
    }
  }
}
