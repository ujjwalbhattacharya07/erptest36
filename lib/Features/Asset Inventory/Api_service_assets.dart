import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceAssets {
  static const String url = 'http://192.168.1.106:8082/assetsapi/fetchasset';

  Future<List<Asset>> fetchAssets() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response);
      List<dynamic> data = jsonDecode(response.body);
      List<Asset> assets = data.map((item) => Asset.fromJson(item)).toList();
      return assets;
    } else {
      throw Exception('Failed to load assets');
    }
  }
}

class Asset {
  final int assetId;
  final String assetName;
  final String assetDescription;
  final String? dateOfPurchase;
  final double costValue;
  final String location;
  final int warranty;
  final bool useStatus;

  Asset({
    required this.assetId,
    required this.assetName,
    required this.assetDescription,
    required this.dateOfPurchase,
    required this.costValue,
    required this.location,
    required this.warranty,
    required this.useStatus,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
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
