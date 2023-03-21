import 'package:flutter/material.dart';
import '../../models/post.dart';
import '../../pages/edit_page.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Post>? allPosts;
  String token;

  CustomSearchDelegate({required this.allPosts, required this.token});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Post> matchQuery = [];
    for (var note in allPosts!) {
      if (note.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(note!);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
              title: Row(children: [
            Text("Result: ${result.name}"),
            Expanded(flex: 1, child: SizedBox()),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return NoteEditPage(token: token, id: result.id!);
                    },
                  ));
                },
                child: Icon(Icons.update)),
            SizedBox(width: 10),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.delete)),
          ]));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var note in allPosts!) {
      if (note.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(note.name!);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
