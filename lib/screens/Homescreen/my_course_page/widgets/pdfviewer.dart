import 'package:flutter/material.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can use any PDF viewer package or widget here
    // For demonstration purposes, I'm just displaying the URL
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: Text('PDF URL: $pdfUrl'),
      ),
    );
  }
}
