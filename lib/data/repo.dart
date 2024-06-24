

import 'package:joker/data/model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Either<String,Joke>> viewRandomJoke()async{

  final response = await http.get(Uri.parse(

      'https://v2.jokeapi.dev/joke/Any'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    print('Response body: ${ json.decode(response.body)}');

    Map<String, dynamic> data = json.decode(response.body);
    //print('Data: $data');
    Flag flag=Flag(nsfw: data['flags']['nsfw'], religious: data['flags']['religious'], political: data['flags']['political'], racist: data['flags']['racist'], explicit: data['flags']['explicit'], sexist: data['flags']['sexist']);
    Joke joke=Joke(id: data['id'], safe: data['safe'], lang: data['lang'], error: data['error'], category: data['category'], type: data['type'], setup: data['setup'], delivery: data['delivery'], flag: flag);
    print('Joke: $joke');
    return Right(joke);


  } else {
    print('failed to load data');
    // If the server did not return a 200 OK response, throw an exception.
    //throw Exception('Failed to load data');
    return Left('Failed to load data');
  }
}

Future<Either<String,Joke>> viewJoke(String category)async{

  final response = await http.get(Uri.parse(

      'https://v2.jokeapi.dev/joke/${category}'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    print('Response body: ${ json.decode(response.body)}');

    Map<String, dynamic> data = json.decode(response.body);
    //print('Data: $data');
    Flag flag=Flag(nsfw: data['flags']['nsfw'], religious: data['flags']['religious'], political: data['flags']['political'], racist: data['flags']['racist'], explicit: data['flags']['explicit'], sexist: data['flags']['sexist']);
    Joke joke=Joke(id: data['id'], safe: data['safe'], lang: data['lang'], error: data['error'], category: data['category'], type: data['type'], setup: data['setup'], delivery: data['delivery'], flag: flag);
    print('Joke: $joke');
    return Right(joke);


  } else {
    print('failed to load data');
    // If the server did not return a 200 OK response, throw an exception.
    //throw Exception('Failed to load data');
    return Left('Failed to load data');
  }
}