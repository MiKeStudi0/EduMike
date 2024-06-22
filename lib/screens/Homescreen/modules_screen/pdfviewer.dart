import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
class PdfScreen extends StatelessWidget {
  final String pdfUrl; // Your Firebase Storage PDF URL

  const PdfScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Container(
          
        
          child: const PDF(
            pageSnap: true,
            autoSpacing: false,
            fitPolicy: FitPolicy.WIDTH,
            pageFling : true,
          fitEachPage: true,
        ).cachedFromUrl(pdfUrl),
        
        ),
      ),
    );
  }



    PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('PDF Viewer', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))) ,
      backgroundColor: const Color.fromARGB(255, 66, 188, 249),
     
    );
  }
}
