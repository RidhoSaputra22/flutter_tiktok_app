import 'package:flutter_tiktok_app/models/user.dart';

class Komentar {
  final String id;
  final String komentar;
  final String dateCreated;
  final User user;

  Komentar({
    required this.id,
    required this.komentar,
    required this.dateCreated,
    required this.user,
  });

  factory Komentar.fromJson(Map<String, dynamic> json) {
    return Komentar(
      id: json['id'].toString(),
      komentar: json['komentar'],
      dateCreated: json['dateCreated'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'komentar': komentar,
        'dateCreated': dateCreated,
        'user': user.toJson(),
      };
}
