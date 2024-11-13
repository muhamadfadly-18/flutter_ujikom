import 'package:flutter/material.dart';
import 'package:ujikom/services/api_service.dart';
import 'package:ujikom/models/Informasi.dart';

class InformasiPage extends StatefulWidget {
  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  final ApiService apiService = ApiService();
  late Future<List<Informasi>> informasiList;

  @override
  void initState() {
    super.initState();
    informasiList = apiService.fetchInformasi();
  }

  void _refreshData() {
    setState(() {
      informasiList = apiService.fetchInformasi();
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Manage Informasi')),
    body: FutureBuilder<List<Informasi>>(
      future: informasiList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20, // Menambah jarak antar kolom
              columns: [
                DataColumn(label: Expanded(child: Text('No', style: TextStyle(fontSize: 16)))),
                DataColumn(label: Expanded(child: Text('Judul', style: TextStyle(fontSize: 16)))),
                DataColumn(label: Expanded(child: Text('Deskripsi', style: TextStyle(fontSize: 16)))),
                DataColumn(label: Expanded(child: Text('Foto', style: TextStyle(fontSize: 16)))),
                DataColumn(label: Expanded(child: Text('Kategori', style: TextStyle(fontSize: 16)))),
                DataColumn(label: Expanded(child: Text('Action', style: TextStyle(fontSize: 16)))),
              ],
              rows: List<DataRow>.generate(
                snapshot.data!.length,
                (index) {
                  final item = snapshot.data![index];
                  return DataRow(cells: [
                    DataCell(Expanded(child: Text('${index + 1}', style: TextStyle(fontSize: 14)))),
                    DataCell(Expanded(child: Text(item.judul, style: TextStyle(fontSize: 14)))),
                    DataCell(Expanded(child: Text(item.deskripsi, style: TextStyle(fontSize: 14)))),
                    DataCell(
                      Expanded(child: Image.network(
                        item.foto,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image_not_supported, size: 50);
                        },
                      )),
                    ),
                    DataCell(Expanded(child: Text(item.kategoriId != 0 ? item.kategoriId.toString() : 'N/A', style: TextStyle(fontSize: 14)))),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _showEditDialog(item),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteInformasi(item.id),
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
              ),
            ),
          );
        }
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _showCreateDialog,
      child: Icon(Icons.add),
    ),
  );
}


  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Judul'),
                onChanged: (value) {
                  // Handle user input
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Deskripsi'),
                onChanged: (value) {
                  // Handle user input
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Informasi item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: item.judul),
                decoration: InputDecoration(labelText: 'Judul'),
                onChanged: (value) {
                  // Handle user input
                },
              ),
              TextField(
                controller: TextEditingController(text: item.deskripsi),
                decoration: InputDecoration(labelText: 'Deskripsi'),
                onChanged: (value) {
                  // Handle user input
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteInformasi(int id) async {
    try {
      await apiService.deleteInformasi(id);
      _refreshData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data: $e')),
      );
    }
  }
}
