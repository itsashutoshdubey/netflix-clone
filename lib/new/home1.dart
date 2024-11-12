import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/new/detail.dart';
import 'package:netflix/new/search.dart';


import '../utils/text.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
List<Sample> sample = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('NetFlix Clone from Ashutosh'),
            GestureDetector(
              onTap: (){

                WidgetsBinding.instance.addPostFrameCallback((_){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                });
              },
                child: Icon(Icons.search, color: Colors.blue,))
          ],
        ),
      )
      ,body:  FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: sample.length,
                  itemBuilder: (context, index) {
                    if(index>=0 && index < sample.length) {
                      return Container(
                      padding: EdgeInsets.all(5),
                      // color: Colors.green,
                      width: 250,
                      child: GestureDetector(
                       onTap: (){
                       }
                       //Details(index)
                       ,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(sample[index].show.image?.medium ?? ''),
                                    fit: BoxFit.cover),
                              ),
                              height: 500,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                size: 15,
                                text: sample[index].show.name != null
                                    ? sample[index].show.name
                                    : 'Loading', color: Colors.black,),
                            ),
                           ElevatedButton(onPressed: (){
                             if(snapshot.hasData && index< sample.length)
                             {
                               WidgetsBinding.instance.addPostFrameCallback((_){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(sample1: sample[index])));
                               });
                             }
                             else {
                               Center(child: CircularProgressIndicator(),);
                             }

                           }, child: Text("Details"))
                           /* Container(
                              child: modified_text(
                                size: 15,
                                text: sample[index].show.summary != null
                                    ? sample[index].show.summary
                                    : 'Loading', color: Colors.black,),
                            )*/
                          ],
                        ),
                      ),
                    );} else {
                      Text("no image");
                    }
                  }
              );
            }
          else {
            return Center(child: CircularProgressIndicator(),);
          }

        }
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
