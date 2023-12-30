class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  Quote.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String,
        author = json['author'] as String;

  Map<String, dynamic> toJson() => {
        'text': text,
        'author': author,
      };
}
