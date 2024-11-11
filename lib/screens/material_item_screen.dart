import 'package:flutter/material.dart';
import '../models/material_item.dart';
import '../services/material_service.dart';

class MaterialItemsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  MaterialItemsScreen({required this.categoryId, required this.categoryName});

  @override
  _MaterialItemsScreenState createState() => _MaterialItemsScreenState();
}

class _MaterialItemsScreenState extends State<MaterialItemsScreen> {
  late Future<List<MaterialItem>> futureMaterials;
  late MaterialService materialService;

  @override
  void initState() {
    super.initState();
    materialService = MaterialService(apiUrl: _buildApiUrl());
    futureMaterials = materialService.fetchMaterials();
  }

  String _buildApiUrl() {
    return "https://absolutestonedesign.com/wp-json/wp/v2/materials?material_category=${widget.categoryId}";
  }

  void _incrementLike(MaterialItem material) async {
    try {
      final updatedLikes = await materialService.likeMaterial(material.id);
      setState(() {
        material.likes = updatedLikes; // Update the like count locally
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to like material: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: FutureBuilder<List<MaterialItem>>(
        future: futureMaterials,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No materials found"));
          }

          final materials = snapshot.data!;
          return ListView.builder(
            itemCount: materials.length,
            itemBuilder: (context, index) {
              final material = materials[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  leading: material.imageUrl.isNotEmpty
                      ? Image.network(
                    material.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image_not_supported, size: 50),
                  title: Text(material.title, style: TextStyle(fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up, color: Colors.blue),
                            onPressed: () => _incrementLike(material),
                          ),
                          Text('${material.likes} likes'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
