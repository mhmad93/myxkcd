import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Comic {
  final String title;
  final int num;
  final String img;

  Comic({this.title, this.num, this.img});

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      title: json['title'] as String,
      num: json['num'] as int,
      img: json['img'] as String,
    );
  }
}

class ListComic {
  Future<Comic> fetchComic() async {
    final response = await http.get("https://xkcd.com/info.0.json");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Comic.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

