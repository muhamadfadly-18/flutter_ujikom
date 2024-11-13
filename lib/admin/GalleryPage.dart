import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ujikom/models/gallery_item.dart'; // Model for Gallery Item

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<List<GalleryItem>> futureGalleryData;

  @override
  void initState() {
    super.initState();
    futureGalleryData = fetchGalleryData();
  }

  Future<List<GalleryItem>> fetchGalleryData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/datagallery'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => GalleryItem.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load gallery data');
    }
  }

  // Function to show a dialog for creating a new item
  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Text')),
              TextField(decoration: InputDecoration(labelText: 'Tanggal')),
              TextField(decoration: InputDecoration(labelText: 'Foto')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality to create item
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Function to show a dialog for editing an item
  void _showEditDialog(GalleryItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: TextEditingController(text: item.text), decoration: InputDecoration(labelText: 'Text')),
              TextField(controller: TextEditingController(text: item.tanggal), decoration: InputDecoration(labelText: 'Tanggal')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality to update item
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Function to show a confirmation dialog for deleting an item
  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Yakin Hapus?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality to delete item
                Navigator.pop(context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: FutureBuilder<List<GalleryItem>>(
        future: futureGalleryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final galleryItems = snapshot.data!;
            return Column(
              children: [
                ElevatedButton(
                  onPressed: _showCreateDialog,
                  child: Text('Tambah Data'),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Text')),
                        DataColumn(label: Text('Tanggal')),
                        DataColumn(label: Text('Foto')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: galleryItems.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(Text(item.id.toString())),
                            DataCell(Text(item.text)),
                            DataCell(Text(item.tanggal)),
                            DataCell(Image.network(item.fotoUrl, width: 50, height: 50)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _showEditDialog(item),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _showDeleteDialog(item.id),
                                ),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
