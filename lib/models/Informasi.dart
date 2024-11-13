class Informasi {
  final int id;
  final String judul;
  final String deskripsi;
  final String foto;
  final int kategoriId;
  final String createdAt;
  final String updatedAt;

  Informasi({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.foto,
    required this.kategoriId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor untuk mengonversi JSON menjadi objek Informasi
  factory Informasi.fromJson(Map<String, dynamic> json) {
    return Informasi(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      foto: json['foto'],
      kategoriId: json['kategori_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}