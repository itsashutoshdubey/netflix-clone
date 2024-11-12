import 'package:flutter/material.dart';
import 'package:netflix/new/home1.dart';
import 'package:netflix/new/splashscreen.dart';
import 'package:netflix/utils/text.dart';



import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}


