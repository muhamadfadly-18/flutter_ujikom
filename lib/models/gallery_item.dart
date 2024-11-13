class GalleryItem {
  final int id;
  final String text;
  final String tanggal;
  final String fotoUrl;

  GalleryItem({required this.id, required this.text, required this.tanggal, required this.fotoUrl});

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'],
      text: json['text'],
      tanggal: json['tanggal'],
      fotoUrl: json['foto_url'], // Mapping `foto_url` from API to `fotoUrl` field
    );
  }
}
