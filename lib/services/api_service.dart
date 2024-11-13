import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ujikom/models/Informasi.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/datainofrmasi';  // Ganti dengan URL API Anda

  // Method untuk mengambil data informasi
  Future<List<Informasi>> fetchInformasi() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      
      // Mengakses field 'data' yang berisi list informasi
      List<dynamic> data = jsonResponse['data'];

      // Mengonversi list data ke dalam List<Informasi>
      return data.map((informasi) => Informasi.fromJson(informasi)).toList();
    } else {
      throw Exception('Failed to load informasi');
    }
  }

  // Method untuk membuat data baru
  Future<void> createInformasi(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/informasi'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create informasi');
    }
  }

  // Method untuk memperbarui data yang sudah ada
  Future<void> updateInformasi(int id, Map<String, String> data) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/informasi/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update informasi');
    }
  }

  // Method untuk menghapus data
  Future<void> deleteInformasi(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/informasi/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete informasi');
    }
  }
}