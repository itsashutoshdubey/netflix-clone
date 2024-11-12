import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netflix/new/home1.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState(){
super.initState();
    Timer(Duration(seconds: 3),
        ()=>Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => Home1()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/netflix_SplashScreen_1920x1080-v2-e1407366325455.jpg'),
        ),
      ),
    );
  }
}
