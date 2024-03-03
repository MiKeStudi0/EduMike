import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(widget.pdfUrl,canShowPageLoadingIndicator: true,),
    );
  }
}
