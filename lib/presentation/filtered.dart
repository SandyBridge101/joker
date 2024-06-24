import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:joker/data/repo.dart';

import '../data/model.dart';


class MyJokePage extends StatefulWidget {
  const MyJokePage({super.key, required this.category});

  final String category;

  @override
  State<MyJokePage> createState() => _MyJokePageState();
}

class _MyJokePageState extends State<MyJokePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.category),

      ),
      body:FutureBuilder<Either<String,Joke>>(
        future: viewJoke(widget.category), // Change the ID as needed
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(
              'Enough jokes for now, time to touch grass',
              style: Theme.of(context).textTheme.headlineMedium,
            )
            );
          } else if (snapshot.hasData) {
            print('loading..');
            Either<String,Joke>? result=snapshot.data;
            Flag flag=Flag(nsfw: false, religious: false, political: false, racist: false, explicit: false, sexist: false);
            Joke joke=Joke(id: 0, safe: false, lang: '', error: false, category: '', type: '', setup: '', delivery: '', flag: flag);
            result!.fold(
                    (error)=>error,
                    (res)=>joke=res
            );
            print(joke.delivery);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Center(
                    child:Text(
                      joke.setup!,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Center(
                    child:Text(
                      joke.delivery!,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                ],
              ),
            );

          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.arrow_back),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}