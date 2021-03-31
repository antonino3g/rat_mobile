import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rat_mobile/routes/routes.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rat_mobile/pages/pdf_preview_screen.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    //orientation screen Portrait
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  final myController = TextEditingController();

  String barcode = 'Unknown';

  String _clientName;
  String _userName;
  String _serialNumber;
  String _signature;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildClientName() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Client'),
        maxLength: 30,
        validator: (String value) {
          if (value.trim().isEmpty) {
            return 'Name is required';
          }
        },
        onSaved: (String value) {
          _clientName = value;
        });
  }

  Widget _buildUserName() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'User'),
        validator: (String value) {
          if (value.trim().isEmpty) {
            return 'User name is required';
          }
        },
        onSaved: (String value) {
          _userName = value;
        });
  }

  // SCAN BarCode & QR Code

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      ).then((value) => setState(() => myController.text = value));
    } on PlatformException {
      barcode = 'Failed to get platform version.';
    }
  }

  _printLatestValue() {
    print("${myController.text}");
  }

  Widget _buildSerialNumber() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Serial Number'),
        controller: myController,
        validator: (String value) {
          if (value.trim().isEmpty) {
            return 'Serial Number is required';
          }
        },
        onSaved: (String value) {
          _serialNumber = value;
        });
  }

  Widget _buildSignature() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Signature'),
        validator: (String value) {
          if (value.trim().isEmpty) {
            return 'Signature is required';
          }
        },
        onSaved: (String value) {
          _signature = value;
        });
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () async {
        writeOnPdf();
        await savePdf();

        Directory documentDirectory = await getApplicationDocumentsDirectory();

        String documentPath = documentDirectory.path;

        String fullPath = "$documentPath/example.pdf";

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PdfPreviewScreen(
                      path: fullPath,
                    )));
      },
      child: Icon(Icons.save),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RAT SONDA / CTIS'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.desktop_mac_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.SIGNATURE);
              })
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.

      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildClientName(),
              _buildUserName(),
              _buildSerialNumber(),
              _buildSignature(),
              FlatButton(
                  child: Icon(Icons.settings_overscan),
                  onPressed: () => [
                        scanBarcode(),
                      ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_formKey.currentState.validate()) {
            return;
          }

          _formKey.currentState.save();

          print(_clientName);
          print(_userName);
          print(_serialNumber);
          print(_signature);

          writeOnPdf();
          await savePdf();

          Directory documentDirectory =
              await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;

          String fullPath = "$documentPath/example.pdf";

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(
                        path: fullPath,
                      )));
        },
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

//PDF
  final pdf = pw.Document();

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
          pw.Paragraph(text: "${_clientName}"),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Header(level: 1, child: pw.Text("Second Heading")),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        ];
      },
    ));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("PDF Flutter"),
//     ),

// }

/**
 * FIM PDF
 */
}
