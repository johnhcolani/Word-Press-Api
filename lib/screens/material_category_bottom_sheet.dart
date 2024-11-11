import 'package:flutter/material.dart';
import 'material_item_screen.dart';
import 'material_list_screen.dart';

class MaterialCategoryBottomSheet extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Granite", "id": "73"},
    {"name": "Marble", "id": "74"},
    {"name": "Quartz", "id": "75"},
    {"name": "Eco-Friendly Material", "id": "76"},
    {"name": "Sink", "id": "77"},
    {"name": "Tiles", "id": "78"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Material Category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(category["name"]!),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaterialItemsScreen(
                        categoryId: category["id"]!,
                        categoryName: category["name"]!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
