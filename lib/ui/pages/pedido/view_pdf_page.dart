import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ventas_facil/models/venta/pedido.dart';

class ViewPDFPage extends StatefulWidget {
  final Pedido pedido;
  final Uint8List fetchPDF;

  ViewPDFPage({Key? key, required this.pedido, required this.fetchPDF}) : super(key: key);

  @override
  _ViewPDFPageState createState() => _ViewPDFPageState();
}

class _ViewPDFPageState extends State<ViewPDFPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reporte de Pedido Nro. ${widget.pedido.codigoSap}")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final filePath = await saveTemporaryPdfFile(widget.fetchPDF, 'pedido_${widget.pedido.numeroDocumento}.pdf');
          sharePdf(filePath);
        }, 
        icon: const Icon(Icons.share),
        label: const Text('Compartir')),
      body: PDFView(
        pdfData: widget.fetchPDF,
        preventLinkNavigation: true,
        nightMode: false,
      )
    );
  }

  void sharePdf(String filePath) {
    Share.shareFiles([filePath], text: 'Aquí tienes el PDF que querías ver.');
  }

  Future<String> saveTemporaryPdfFile(Uint8List pdfData, String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(pdfData);
    return file.path;
  }
}
