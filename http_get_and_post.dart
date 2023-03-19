
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class HttpRequest extends StatefulWidget {
  @override
  _HttpRequestState createState() => _HttpRequestState();
}

class _HttpRequestState extends State<HttpRequest> {
  final url = "https://jsonplaceholder.typicode.com/posts";

  var _postsJson = [];

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  void postData() async {
    try{
      final response = await post(Uri.parse(url), body: {
        "title": "Anything",
        "body": "Post body",
        "userId": "1"
      });
      print(response.body);
    } catch(er){}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:200),
            ElevatedButton(
              onPressed: fetchPosts,
              child: Text("Get request"),
            ),
            ElevatedButton(
              onPressed: postData,
              child: Text("Post request"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _postsJson.length,
                itemBuilder: (context, i) {
                  final post = _postsJson[i];
                  return Text("Title: ${post["title"]}\n Body: ${post["body"]}\n\n");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
