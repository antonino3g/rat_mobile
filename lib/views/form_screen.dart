import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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

  // void _setBarCodeValueIntoTextFormFieldSerialNumber() {
  //   setState(() {
  //     _serialNumber = barcode;
  //     barcode += _serialNumber;
  //   });
  // }

  Widget _buildSerialNumber() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Serial Number'),
        controller: myController,
        // validator: (String value) {
        //   if (value.trim().isEmpty) {
        //     return 'Serial Number is required';
        //   }
        // },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RAT SONDA / CTIS'),
      ),
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
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  print(_clientName);
                  print(_userName);
                  print(_serialNumber);
                  print(_signature);
                },
              ),
              FlatButton(
                  child: Icon(Icons.settings_overscan),
                  onPressed: () => [
                        scanBarcode(),
                        // _setBarCodeValueIntoTextFormFieldSerialNumber(),
                      ]),
            ],
          ),
        ),
      ),
    );
  }
}
