import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/material.dart';

class Pdfviewerpage extends StatefulWidget {

  bool done;
  String nomCourss;
  int numChapitre;
  Pdfviewerpage({this.nomCourss, this.numChapitre, this.done});

  @override
  _PdfviewerpageState createState() => _PdfviewerpageState(nomCourss, numChapitre, done);
}

class _PdfviewerpageState extends State<Pdfviewerpage> {

  bool done;
  String nomCourss;
  int numChapitre;
  _PdfviewerpageState(this.nomCourss, this.numChapitre, this.done);

  @override
  void initState() {
    super.initState();
    loadfile();
  }

  PDFDocument document;

  loadfile() async {
    if (nomCourss == "Oracle" ) {
      switch (numChapitre){
        case 1 :
          document = await PDFDocument.fromAsset('assets/oracle1.pdf');
          setState(() {
            document = document;
          });
          break;
        case 2:
          document = await PDFDocument.fromAsset('assets/oracle2.pdf');
          setState(() {
            document = document;
          });
          break;
      }
  }

    if (nomCourss == "Java" ) {
      switch (numChapitre){
        case 1 :
          document = await PDFDocument.fromAsset('assets/seance1.pdf');
          setState(() {
            document = document;
          });
          break;
        case 2:
          document = await PDFDocument.fromAsset('assets/seance2.pdf');
          setState(() {
            document = document;
          });
          break;
        case 3:
          document = await PDFDocument.fromAsset('assets/seance3.pdf');
          setState(() {
            document = document;
          });
          break;
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: PDFViewer(document: document),
    );
  }
}
