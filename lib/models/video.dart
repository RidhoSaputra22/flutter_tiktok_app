import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_tiktok_app/config.dart';
import 'package:flutter_tiktok_app/models/auth.dart';
import 'package:flutter_tiktok_app/models/komentar.dart';
import 'package:flutter_tiktok_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String datePosted;
  final String views;
  final String likes;
  final String description;
  final User user;
  final List<Komentar> komentar;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.datePosted,
    required this.views,
    required this.likes,
    required this.description,
    required this.user,
    required this.komentar,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'].toString(),
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      videoUrl: json['videoUrl'],
      datePosted: json['datePosted'],
      views: json['views'],
      likes: json['likes'],
      description: json['description'],
      user: User.fromJson(json['user']),
      komentar: (json['komentar'] as List<dynamic>)
          .map((e) => Komentar.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'datePosted': datePosted,
      'views': views,
      'likes': likes,
      'description': description,
      'user': user.toJson(),
      'komentar': komentar.map((e) => e.toJson()).toList(),
    };
  }

  static Future<void> uploadVideoWeb({
    required FilePickerResult video,
    required String title,
    required String desc,
    // required String userId,
  }) async {
    print(video.files.single.name);
    print(Config.apiBaseUrl);
    try {
      final String? id = await AuthService.getUserId();
      var formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(video.files.first.bytes!,
            filename: video.files.single.name),
        'thumbnail': "null",
        'title': title,
        'user_id': id,
        'description': desc,
      });

      Dio dio = Dio();

      var response = await dio.post(
        '${Config.apiBaseUrl}/video',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('Upload berhasil: ${response.data}');
    } catch (e) {
      print('Upload gagal: $e');
    }
  }

  static Future<List<Video>> fetchVideos() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.apiBaseUrl}/video'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => Video.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch videos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching videos: $e');
    }
  }
}
