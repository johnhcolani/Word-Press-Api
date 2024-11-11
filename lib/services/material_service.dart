import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/material_item.dart';

class MaterialService {
  final String apiUrl;

  MaterialService({required this.apiUrl});

  Future<List<MaterialItem>> fetchMaterials() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final materials = data.map((json) => MaterialItem.fromJson(json)).toList();

      for (var material in materials) {
        await material.fetchImageUrl(); // Fetch image URLs
      }

      return materials;
    } else {
      throw Exception("Failed to load materials");
    }
  }

  Future<int> likeMaterial(int materialId) async {
    final response = await http.post(
      Uri.parse('https://absolutestonedesign.com/wp-json/materials/v1/like/$materialId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['likes']; // Return updated like count
    } else {
      throw Exception("Failed to update likes");
    }
  }
}
