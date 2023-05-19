import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  List movie = [];
  final dio = Dio();

  @override
  void initState() {
    readyMovieList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOVIE LIST"),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: movie.length,
          itemBuilder: (BuildContext context, int index) {

            print(movie[index]);

            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(movie[index]['poster']), 
                placeholder: AssetImage('assets/placeholder_image.jpg'),
                width: 50,
                height: 50,
              ),
              title: Text(movie[index]['title']),
              subtitle: Text(
                          movie[index]['description'],
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        ),
              tileColor: Colors.green,
              
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }

  readyMovieList() async{

    Response response;
    response = await dio.get('https://dlabs-test.irufano.com/api/movie?size=10&page=1');
    var data = response.data['data'];
    for(int i=0;i<data.length;i++){
      movie.add(data[i]);
    }
  }
}