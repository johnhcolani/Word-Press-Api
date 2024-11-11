import 'package:flutter/material.dart';
import 'material_category_bottom_sheet.dart';

class MaterialListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Granites App")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showMaterialCategories(context),
          child: Text("Show Materials", style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
      ),
    );
  }

  void _showMaterialCategories(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MaterialCategoryBottomSheet(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
