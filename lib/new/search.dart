import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/model.dart';
import 'package:netflix/new/detail.dart';

import '../utils/text.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Sample> sample = [];
  final TextEditingController _controller = TextEditingController();
  var search = 'movie';
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onSubmitted: (query){
              setState(() {
                search = query;
              });
            },
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Search Movie',
            ),
          ),
          FutureBuilder(
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
         // Text('what up' , style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
  Future<List<Sample>> getData() async{
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=${search}'));
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
