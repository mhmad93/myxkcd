import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myxkcd/comic.dart';

class ComicScreen extends StatefulWidget {
  ComicScreen({Key key}) : super(key: key);

  @override
  _ComicScreen createState() => _ComicScreen();
}

class _ComicScreen extends State<ComicScreen> {
   Future<Comic> futureComic;

  @override
  void initState() {
    super.initState();
    futureComic = ListComic().fetchComic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Xkcd Viewer'),
        backgroundColor: Colors.black26,
      ),
      body: FittedBox(
              child: new FutureBuilder<Comic>(
                future: futureComic,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return setComic(snapshot);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                  },
              ),
        ),
    );
  }

  Widget setComic(AsyncSnapshot<Comic> snapshot){
    Size size = MediaQuery.of(context).size;
    var comic = snapshot.data;
    return Column(
        children: <Widget>[
          SizedBox(height: size.height*0.09),
          Text(comic.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          SizedBox(height: size.height*0.05),
          Image.network(comic.img, width: size.width -10,
          ),
        ]
    );
  }
}