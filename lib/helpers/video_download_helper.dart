import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> fetchDownloadLink(String videoUrl) async {
  final uri = Uri.parse('https://snap-video3.p.rapidapi.com/download');
  final headers = {
    'X-Rapidapi-Key': '9c94501870msh4aa4a21ebb9aba6p1adb72jsnd8956044b141',
    'X-Rapidapi-Host': 'snap-video3.p.rapidapi.com',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  final body = 'url=${Uri.encodeComponent(videoUrl)}';

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['medias'] != null &&
          result['medias'] is List &&
          result['medias'].isNotEmpty) {
        final media = result['medias'].firstWhere(
          (item) => item['url'] != null,
          orElse: () => null,
        );
        return media?['url']; // Return the download link
      }
    }
  } catch (e) {
    return null; // Return null if an error occurs
  }
  return null;
}
