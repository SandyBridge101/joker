import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:joker/data/repo.dart';
import 'package:joker/presentation/filtered.dart';

import '../data/model.dart';


class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('DashBoard'),
      ),
      body:FutureBuilder<Either<String,Joke>>(
      future: viewRandomJoke(), // Change the ID as needed
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
          String delivery="None";
          String setup="None";

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
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child:                   Wrap(
                    children: <Widget>[
                      ElevatedButton(
                          onPressed:(){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyJokePage(category: 'Miscellaneous',)));}
                          , child: Text('Miscellaneous')),
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyJokePage(category: 'Programming',)));
                      },
                          child: Text('Programming')),
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyJokePage(category: 'Dark',)));},
                          child: Text('Dark')),
                      ElevatedButton(onPressed:(){Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyJokePage(category: 'Pun',)));},
                          child: Text('Pun')),
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyJokePage(category: 'Spooky',)));
                      },
                          child: Text('Spooky')),
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyJokePage(category: 'Christmas',)));
                      },
                          child: Text('Christmas')),
                    ],
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
          setState(() {

          });
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

