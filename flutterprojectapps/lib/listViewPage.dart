// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutterprojectapps/addMoviePage.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  bool isShow = false;
  
  String message = "Please wait ...";
  List movie = [];

  final dio = Dio();

  @override
  void initState() {
    super.initState();
    readyMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOVIE LIST"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  message = "Please wait ...";
                });
                readyMovieList();
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        child: 
        Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.right,
          child: 
          (!isShow)?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: CircularProgressIndicator(
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(message),
            ],
          )
          :
          ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: movie.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie[index]['poster']), 
                  placeholder: const AssetImage('assets/placeholder_image.jpg'),
                  width: 50,
                  height: 50,
                ),
                title: Text(movie[index]['title']),
                subtitle: Text(
                            movie[index]['description'],
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                          ),
                tileColor: Colors.blue[200],
                onTap: () {
                  showDialog(context: context, builder: (BuildContext context) =>
                    AlertDialog(
                      title: Text(movie[index]['title']),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: FadeInImage(
                                image: NetworkImage(movie[index]['poster']), 
                                placeholder: const AssetImage('assets/placeholder_image.jpg'),
                              ),
                            ),
                            const Divider(),
                            Text(
                              movie[index]['description'],
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return const AddMoviePage();
            })
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }

  readyMovieList() async{

    setState(() {
      isShow = false;
    });

    try{
      Response response;
      response = await dio.get('https://dlabs-test.irufano.com/api/movie?size=10&page=1');

      if(response.statusCode == 200){
        var data = response.data['data'];
        for(int i=0;i<data.length;i++){
          movie.add(data[i]);
        }

        setState(() {
          isShow = true;
        });

      }else{
        setState(() {
          message = "Failed to load data ...";
        });
      }
      
    }catch(e){

      setState(() {
        message = "Failed to reach server ...";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to reach server ...',
          ),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}