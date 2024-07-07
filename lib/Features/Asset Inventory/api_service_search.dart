import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceSearchAsset {
  static const String baseUrl = 'http://192.168.1.106:8082/assetsapi/searchasset';

  Future<Asset2?> fetchAsset(int assetId) async {
    try {
      final url = Uri.parse('$baseUrl?asset_id=$assetId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Asset2.fromJson(data);
      } else {
        throw Exception('Failed to load asset');
      }
    } catch (e) {
      print('Error fetching asset: $e');
      return null;
    }
  }
}

class Asset2 {
  final int assetId;
  final String assetName;
  final String assetDescription;
  final String? dateOfPurchase;
  final double costValue;
  final String location;
  final int warranty;
  final bool useStatus;

  Asset2({
    required this.assetId,
    required this.assetName,
    required this.assetDescription,
    required this.dateOfPurchase,
    required this.costValue,
    required this.location,
    required this.warranty,
    required this.useStatus,
  });

  factory Asset2.fromJson(Map<String, dynamic> json) {
    return Asset2(
      assetId: json['asset_id'],
      assetName: json['asset_name'],
      assetDescription: json['asset_description'],
      dateOfPurchase: json['date_of_purchase'],
      costValue: json['cost_value'].toDouble(),
      location: json['location'],
      warranty: json['warranty'],
      useStatus: json['use_status'],
    );
  }
}
