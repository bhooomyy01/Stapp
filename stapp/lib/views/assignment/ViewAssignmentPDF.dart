import 'package:flutter/material.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';
import 'package:stapp/Widgets/widgetapp.dart';

class ViewAssignment extends StatefulWidget {
  final String urlkey;
  ViewAssignment({this.urlkey});
  @override
  _ViewAssignmentState createState() => _ViewAssignmentState();
}

class _ViewAssignmentState extends State<ViewAssignment> {
  bool _isLoading = true;
  PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    setState(() {
      _isLoading = true;
    });

    document = await PDFDocument.fromURL(widget.urlkey);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(document: document),
    );
  }
}
