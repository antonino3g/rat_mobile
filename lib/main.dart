import 'package:flutter/material.dart';
import 'package:rat_mobile/routes/routes.dart';
import 'package:rat_mobile/views/signature.dart';
import 'views/form_screen.dart';

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
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.SIGNATURE: (_) => SignatureDraw(),
      },
    );
  }
}
