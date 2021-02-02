import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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

  Widget _buildSerialNumber() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Serial Number'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form SONDA'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
