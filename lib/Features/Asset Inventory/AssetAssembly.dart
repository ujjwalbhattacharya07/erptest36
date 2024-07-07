import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/AssetAssemblyCard.dart';
import 'Api_service_assets.dart';
import 'AssetAssembly_lower.dart';
import 'AssetForm.dart';
import 'api_service_search.dart';

class AssetAssembly extends StatefulWidget {
  AssetAssembly({Key? key}) : super(key: key);

  @override
  _AssetAssemblyState createState() => _AssetAssemblyState();
}

class _AssetAssemblyState extends State<AssetAssembly> {
  final ApiServiceAssets apiService = ApiServiceAssets();
  final ApiServiceSearchAsset apiServiceSearch = ApiServiceSearchAsset();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF182871),
        title: Text(
          "Volvo",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AssetCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Find Asset by ID',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _searchAsset,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: AssetLower(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF182871),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: AssetForm(),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          tooltip: 'Increment',
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: AssetForm(),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  void _searchAsset() async {
    final assetId = int.tryParse(_searchController.text);
    if (assetId != null) {
      final asset = await apiServiceSearch.fetchAsset(assetId);
      if (asset != null) {
        showDetailsDialog(context, asset);
      } else {
        // Handle asset not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Asset not found"),
              actions: <Widget>[
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle invalid asset ID
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Please enter a valid asset ID"),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showDetailsDialog(BuildContext context, Asset2 asset) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 300,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text("Details",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Asset ID:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(asset.assetId.toString(),
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(asset.assetName,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                SizedBox(height: 5),
                Text(asset.assetDescription, style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Date of Purchase:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.dateOfPurchase ?? 'N/A',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Cost/Value:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.costValue.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Location:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.location, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Warranty:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.warranty.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Status",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.useStatus ? 'In Use' : 'Not In Use',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
