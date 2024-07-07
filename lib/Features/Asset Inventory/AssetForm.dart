import 'package:flutter/material.dart';
import 'api_service_add_asset.dart';
import 'api_service_assets.dart';

class AssetForm extends StatefulWidget {
  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  final _purchaseDateController = TextEditingController();
  final _assetIdController = TextEditingController();
  final _assetNameController = TextEditingController();
  final _assetDescriptionController = TextEditingController();
  final _costValueController = TextEditingController();
  final _locationController = TextEditingController();
  final _warrantyController = TextEditingController();
  final _useStatusController = TextEditingController();

  @override
  void dispose() {
    _purchaseDateController.dispose();
    _assetIdController.dispose();
    _assetNameController.dispose();
    _assetDescriptionController.dispose();
    _costValueController.dispose();
    _locationController.dispose();
    _warrantyController.dispose();
    _useStatusController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final assetData = {
        "asset_id": int.parse(_assetIdController.text),
        "asset_name": _assetNameController.text,
        "asset_description": _assetDescriptionController.text,
        "date_of_purchase": _purchaseDateController.text,
        "cost_value": double.parse(_costValueController.text),
        "location": _locationController.text,
        "warranty": int.parse(_warrantyController.text),
        "use_status": _useStatusController.text.toLowerCase() == 'true'
      };

      final apiService = ApiServiceAddAsset();
      try {

        bool result = await apiService.addAsset(assetData);
        print("posted:$result");
        if (result) {
          Navigator.of(context).pop(); // Close the form dialog
          final apiServiceAssets = ApiServiceAssets();
          apiServiceAssets.fetchAssets(); // Refresh the asset list
        } else {
          print('Add failed');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _assetIdController,
                      decoration: InputDecoration(
                        labelText: 'ID',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _costValueController,
                      decoration: InputDecoration(
                        labelText: 'Cost',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _assetNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _assetDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _purchaseDateController,
                decoration: InputDecoration(
                  labelText: 'Purchase Date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: Color(0XFF182871)),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _purchaseDateController.text = "${picked.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _warrantyController,
                decoration: InputDecoration(
                  labelText: 'Warranty',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),

                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<bool>(
                value: null,
                onChanged: (bool? newValue) {
                  _useStatusController.text = newValue.toString();
                },
                decoration: InputDecoration(labelText: 'Use Status'),
                items: [
                  DropdownMenuItem(value: true, child: Text('In Use')),
                  DropdownMenuItem(value: false, child: Text('Not In Use')),
                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
