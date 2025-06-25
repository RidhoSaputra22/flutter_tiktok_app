import 'package:flutter/material.dart';

class VideoSearchDelegate extends SearchDelegate<String> {
  final List<String> dummyVideos = [
    'Belajar Matematika',
    'Tips Bahasa Inggris',
    'Eksperimen Fisika',
    'Cerita Edukasi Anak',
    'Tutorial Coding Flutter',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, ''), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Hasil untuk: "$query"', style: const TextStyle(color: Colors.white)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = dummyVideos
        .where((video) => video.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () => query = suggestions[index],
        );
      },
    );
  }
}
