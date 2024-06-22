import 'package:flutter/material.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    // You can use any PDF viewer package or widget here
    // For demonstration purposes, I'm just displaying the URL
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: Center(
        child: Text('PDF URL: $pdfUrl'),
      ),
    );
  }
}
