import 'dart:convert';

// Decode
List<PostModel> postFromJson(String jsonData) {
  final results = json.decode(jsonData);
  return List<PostModel>.from(
      results.map((result) => PostModel.fromJson(result)));
}

// Encode
String postToJson(PostModel postModel) {
  final results = postModel.toJson();
  return json.encode(results);
}

class PostModel {
  int? id;
  int userId;
  String nama;
  String prodi;
  String matkul;
  String nidn;
  String bidang;
  DateTime? createAt;

  PostModel(
      {this.id,
      required this.userId,
      required this.nama,
      required this.prodi,
        required this.matkul,
        required this.nidn,
        required this.bidang,
      this.createAt});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["user_id"],
        nama: json["nama"],
        prodi: json["prodi"],
        matkul: json["matkul"],
    nidn: json["nidn"],
    bidang: json["bidang"],
        createAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama": nama,
        "prodi": prodi,
        "matkul": matkul,
        "nidn": nidn,
        "bidang": bidang,
      };

  // Debug
  // @override
  // String toString() {
  //   return 'PostModel{id: $id, title: $title, description: $description, created_at: $createdAt, updated_at: $updatedAt}';
  // }
}
