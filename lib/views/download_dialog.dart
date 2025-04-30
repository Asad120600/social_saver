import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadDialog extends StatelessWidget {
  final String downloadLink;

  const DownloadDialog({required this.downloadLink, Key? key})
      : super(key: key);

  Future<void> _openInChrome(BuildContext context) async {
    final Uri url = Uri.parse(downloadLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print(e);
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title:
          Text('Download Video', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text('Your video is ready to download!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () => _openInChrome(context),
          child: Text('Download Now'),
        ),
      ],
    );
  }
}
