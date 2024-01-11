class Data {
  final String id;
  final String nama;
  final String email;
  final String kota;
  final String gambar;

  const Data({
    required this.id,
    required this.nama,
    required this.email,
    required this.kota,
    required this.gambar,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    try {
      return Data(
        id: json['id'],
        nama: json['nama'],
        email: json['email'],
        kota: json['kota'],
        gambar: json['gambar'],
      );
    } catch (e) {
      print('Error parsing JSON: $e');
      throw FormatException('Failed to load data.');
    }
  }
}
