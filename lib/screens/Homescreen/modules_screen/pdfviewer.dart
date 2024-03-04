import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String pdfUrl;

  const PdfViewer({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    print('PDF Viewer: PDF URL: ${widget.pdfUrl}');
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SfPdfViewer.network(
        
        widget.pdfUrl,
        canShowPageLoadingIndicator: false,
        scrollDirection: PdfScrollDirection.vertical, // or PdfScrollDirection.horizontal
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
