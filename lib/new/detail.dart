import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix/model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/utils/text.dart';

class DetailScreen extends StatefulWidget {
  var sample1;
   DetailScreen({super.key, required this.sample1});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Sample> sample = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(widget.sample1.show.image?.medium?? ''),
                  fit: BoxFit.cover),
            ),
            height: 500,
          ),
          Container(
            child: modified_text(
              size: 15,
              text: widget.sample1.show.name != null
                  ? widget.sample1.show.name
                  : 'Loading', color: Colors.white,),
          ),
          Container(
            child: modified_text(
              size: 15,
              text: widget.sample1.show.summary != null
                  ? widget.sample1.show.summary
                  : 'Loading', color: Colors.white,),
          ),

        ],
      ),
    );
  }
  Future<List<Sample>> getData() async{
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        sample.add(Sample.fromJson(index));
      }
      print(sample[1].show.image!.medium);
      return sample;
    }
    else{
      return sample;
    }
  }
}
