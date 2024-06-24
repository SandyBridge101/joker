
class Joke{
  final int id;
  final bool safe;
  final String lang;
  final bool error;
  final String category;
  final String type;
  final String setup;
  final String delivery;
  final Flag flag;

  Joke({
    required this.id, required this.safe,required this.lang, required this.error,
    required this.category,required this.type,required this.setup,required this.delivery,
    required this.flag
  });
}

class Flag{
  final bool nsfw;
  final bool religious;
  final bool political;
  final bool racist;
  final bool sexist;
  final bool explicit;
  Flag({required this.nsfw,required this.religious,required this.political,
    required this.racist,required this.explicit,required this.sexist
  });
}
