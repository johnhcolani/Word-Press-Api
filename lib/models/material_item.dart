import 'dart:convert';
import 'package:http/http.dart' as http;

class MaterialItem {
  final int id;
  final String title;
  final String content;
  final int featuredMediaId;
  int likes; // Number of likes
  String imageUrl = '';

  MaterialItem({
    required this.id,
    required this.title,
    required this.content,
    required this.featuredMediaId,
    required this.likes,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'],
      title: json['title']['rendered'] ?? '',
      content: json['content']['rendered'] ?? '',
      featuredMediaId: json['featured_media'] ?? 0,
      likes: json['likes'] ?? 0,
    );
  }

  Future<void> fetchImageUrl() async {
    if (featuredMediaId == 0) return;

    final response = await http.get(Uri.parse(
        'https://absolutestonedesign.com/wp-json/wp/v2/media/$featuredMediaId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      imageUrl = data['source_url'] ?? '';
    }
  }
}
