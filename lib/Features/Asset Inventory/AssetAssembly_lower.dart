import 'package:flutter/material.dart';
import 'api_service_asset_delete.dart';
import 'api_service_assets.dart';
import 'api_service_edit_asset.dart';

class AssetLower extends StatefulWidget {
  const AssetLower({Key? key}) : super(key: key);

  @override
  _AssetLowerState createState() => _AssetLowerState();
}

class _AssetLowerState extends State<AssetLower> {
  late Future<List<Asset>> _futureAssets;
  final ApiServiceAssets apiService = ApiServiceAssets();

  @override
  void initState() {
    super.initState();
    _futureAssets = apiService.fetchAssets();
  }

  Future<void> _refreshAssets() async {
    setState(() {
      _futureAssets = apiService.fetchAssets();
    });
  }
  Future<void> _deleteAsset(int assetId) async {
    try {
      bool success = await ApiServiceDeleteAsset().deleteAsset(assetId);
      if (success) {
        _refreshAssets();
        // Refresh the list after deleting
      } else {
        // Handle deletion failure if needed
      }
    } catch (e) {
      // Handle any API call errors
      print('Error deleting asset: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshAssets,
        child: FutureBuilder<List<Asset>>(
          future: _futureAssets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No assets found'));
            } else {
              List<Asset> assets = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderRow(context),
                      ...assets.map((asset) => _buildAssetRow(asset, context)).toList(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0XFF182871),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                onPressed: _refreshAssets,
                icon: Icon(Icons.refresh, color: Colors.white),
              ),
              _buildHeaderItem("ID"),
              _buildHeaderItem("Name"),
              _buildHeaderItem("Description"),
              _buildHeaderItem("Purchase Date"),
              _buildHeaderItem("Cost"),
              _buildHeaderItem("Location"),
              _buildHeaderItem("Warranty"),
              _buildHeaderItem("Status"),
              SizedBox(width: 100,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem(String text) {
    return SizedBox(
      width: 100,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildAssetRow(Asset asset, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 50,),
              _buildAssetItem(asset.assetId.toString(), context, asset),
              _buildAssetItem(asset.assetName, context, asset),
              _buildAssetItem(asset.assetDescription, context, asset),
              _buildAssetItem(asset.dateOfPurchase ?? 'N/A', context, asset),
              _buildAssetItem(asset.costValue.toString(), context, asset),
              _buildAssetItem(asset.location, context, asset),
              _buildAssetItem(asset.warranty.toString(), context, asset),
              _buildAssetItem(asset.useStatus ? 'In Use' : 'Not In Use', context, asset),
              IconButton(
                onPressed: () {
                  showEditDialog(context, asset);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(onPressed: (){
                showDeleteDialog(context,asset);
              }, icon: Icon(Icons.delete)),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetItem(String text, BuildContext context, Asset asset) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, asset);
      },
      child: SizedBox(
        width: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
  void showDeleteDialog(BuildContext context,Asset asset)
  {
    showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        content: Container(
          height: 150,
          child: Column(
            children: [
              Text("Do you wish to delete this row?"),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                 _deleteAsset(asset.assetId);
                 Navigator.of(context).pop();

                },
              ),
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void showDetailsDialog(BuildContext context, Asset asset) {
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
                Center(child: Text("Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Asset ID:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(asset.assetId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(asset.assetName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                SizedBox(height: 5),
                Text(asset.assetDescription, style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Date of Purchase:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.dateOfPurchase ?? 'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Cost/Value:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.costValue.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Location:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.location, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Warranty:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.warranty.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.useStatus ? 'In Use' : 'Not In Use', style: TextStyle(fontSize: 13)),
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

  void showEditDialog(BuildContext context, Asset asset) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController(text: asset.assetName);
    final TextEditingController _descriptionController = TextEditingController(text: asset.assetDescription);
    final TextEditingController _dateController = TextEditingController(text: asset.dateOfPurchase);
    final TextEditingController _costController = TextEditingController(text: asset.costValue.toString());
    final TextEditingController _locationController = TextEditingController(text: asset.location);
    final TextEditingController _warrantyController = TextEditingController(text: asset.warranty.toString());
    bool _useStatus = asset.useStatus;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Asset'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Asset Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter asset name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Asset Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter asset description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date of Purchase'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter date of purchase';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _costController,
                    decoration: InputDecoration(labelText: 'Cost Value'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cost value';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _warrantyController,
                    decoration: InputDecoration(labelText: 'Warranty (Months)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter warranty period';
                      }
                      return null;
                    },
                  ),
                  SwitchListTile(
                    title: Text('In Use'),
                    value: _useStatus,
                    onChanged: (bool value) {
                      _useStatus = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Edit'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ApiServiceEditAsset apiServiceEditAsset = ApiServiceEditAsset();
                  bool success = await apiServiceEditAsset.editAsset({
                    'asset_id': asset.assetId,
                    'asset_name': _nameController.text,
                    'asset_description': _descriptionController.text,
                    'date_of_purchase': _dateController.text,
                    'cost_value': double.parse(_costController.text),
                    'location': _locationController.text,
                    'warranty': int.parse(_warrantyController.text),
                    'use_status': _useStatus,
                  });

                  if (success) {
                    _refreshAssets(); // Refresh the list after editing
                    Navigator.of(context).pop();
                  } else {
                    // Show error message
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
