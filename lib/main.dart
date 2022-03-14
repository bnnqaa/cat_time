import 'package:flutter/material.dart';
import 'cat_content.dart';


void main() => runApp(CatApp());

class CatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Dose',
      home: SafeArea(
          child: CatContent(),
      ),
    );
  }
}


