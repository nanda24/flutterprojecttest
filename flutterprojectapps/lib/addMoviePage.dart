import 'package:flutter/material.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({super.key});

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD MOVIE"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                prefixIcon: Icon(Icons.abc),
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
                prefixIcon: Icon(Icons.abc),
              ),
              textInputAction: TextInputAction.done,
            )
          ],
        ),
      ),
    );
  }
}