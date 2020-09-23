/*import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/material.dart';

class Pdfviewerpage extends StatefulWidget {
  @override
  _PdfviewerpageState createState() => _PdfviewerpageState();
}

class _PdfviewerpageState extends State<Pdfviewerpage> {

  @override
  void initState() {
    super.initState();
    loadfile();
  }

  PDFDocument document;

  loadfile() async{
    document = await PDFDocument.fromAsset('assets/seance1.pdf');
    setState(() {
      document = document;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: PDFViewer(document: document),
    );
  }
}
*/

