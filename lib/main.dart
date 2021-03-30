import 'package:flutter/material.dart';
// import 'package:rat_mobile/pages/pdf_example.dart';
import 'package:rat_mobile/routes/routes.dart';
import 'package:rat_mobile/pages/signature.dart';
import 'pages/form_screen.dart';
// import 'views/signature.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SONDA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormScreen(),
      // home: PdfExemple(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.SIGNATURE: (_) => SignaturePage(),
      },
    );
  }
}
