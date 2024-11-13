import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ujikom/models/gallery_item.dart'; // Import model yang sudah dibuat

Future<List<GalleryItem>> fetchGalleryData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/datagallery'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => GalleryItem.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load gallery');
  }
}
