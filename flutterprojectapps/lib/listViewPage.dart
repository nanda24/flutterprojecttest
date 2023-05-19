import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

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
        child: Text("Movie Desc"),
      ),
    );
  }

  readyMovieList() async{

    final response = await dio.get('https://dlabs-test.irufano.com/api/movie?size=10&page=1');
    print(response);

  }
}