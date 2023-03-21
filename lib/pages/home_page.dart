import 'dart:async';
import 'package:flutter_front/dio.dart';
import 'package:flutter_front/models/post.dart';
import '../pages/add_page.dart';
import '/pages/edit_page.dart';
import '/widgets/drawers/custom_search_delegate.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  String token;
  HomePage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageStateful(token: token),
    );
  }
}

class HomePageStateful extends StatefulWidget {
  final String? token;
  HomePageStateful({super.key, this.token});

  @override
  State<HomePageStateful> createState() => _HomePageStateful(token: token!);
}

class _HomePageStateful extends State<HomePageStateful> {
  String token;
  List<Post>? _allNotes;

  final Dio_Client _dio = Dio_Client();

  _HomePageStateful({required this.token});

  final Dio_Client _client = Dio_Client();
  @override
  void initState() {
    super.initState();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Future<AlertDialog?> deleteNote(BuildContext context,
      {required int id}) async {
    String? message = await _dio.deleteNote(id: id, token: widget.token!);
    print(message);

    AlertDialog alert = AlertDialog(
      title: const Text('Deleting Note: '),
      content: Text(message!),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            setState(() {});
          },
          child: const Text('OK'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        allPosts: _allNotes, token: widget.token!));
              },
              icon: const Icon(Icons.search))
        ]),
        body: Center(
            child: FutureBuilder<List<Post>?>(
                future: _client.getNotes(token: widget.token!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _allNotes = snapshot.data;
                    return ListView.builder(
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          if (index < snapshot.data!.length!) {
                            return ListTile(
                              title: Row(children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      snapshot.data![index].name!,
                                      textAlign: TextAlign.center,
                                    )),
                                Icon(Icons.notes_outlined)
                              ]),
                              subtitle: ConstrainedBox(
                                constraints:
                                    new BoxConstraints(minHeight: 100.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(116, 154, 155, 1),
                                      border: Border.all(
                                        color: Color.fromRGBO(3, 158, 162, 1),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(children: [
                                          Row(children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                    snapshot
                                                        .data![index].content!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1)),
                                            // Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
                                            ElevatedButton(
                                                onPressed: () {
                                                  deleteNote(
                                                      id: snapshot
                                                          .data![index].id!,
                                                      context);
                                                  // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromRGBO(
                                                      10, 86, 88, 1),
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(10.0),
                                                  ),
                                                  minimumSize: Size(30, 30),
                                                ),
                                                child: const Icon(Icons.delete))
                                          ]),
                                          SizedBox(height: 10.0),
                                          Container(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (BuildContext
                                                          context) {
                                                        return NoteEditPage(
                                                            token:
                                                                widget.token!,
                                                            id: snapshot
                                                                .data![index]
                                                                .id!);
                                                      },
                                                    ));
                                                    // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Color.fromRGBO(
                                                        10, 86, 88, 1),
                                                    shape:
                                                        new RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0),
                                                    ),
                                                    minimumSize: Size(42, 42),
                                                  ),
                                                  child: Text("Update",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1))),
                                          Row(children: [
                                            Text(
                                              "Created: ${snapshot.data![index].creationDate.toLocal().toString().substring(0, 19)}",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black45),
                                              overflow: TextOverflow.fade,
                                            ),
                                            Expanded(
                                                flex: 1, child: SizedBox()),
                                            Text(
                                              "Updated: ${snapshot.data![index].lastUpdating.toLocal().toString().substring(0, 19)}",
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black45),
                                            ),
                                          ]),
                                          SizedBox(height: 10),
                                          Row(children: [
                                            Text(
                                              "Category: ${snapshot.data![index].category.categoryName}",
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black45),
                                            ),
                                            Expanded(
                                                flex: 1, child: SizedBox()),
                                          ])
                                        ]))),
                              ),
                            );
                          } else {
                            return Padding(
                                padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return NoteAddPage(
                                                  token: widget.token!);
                                            },
                                          )).then(onGoBack);
                                          // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromRGBO(10, 86, 88, 1),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          minimumSize: Size(42, 42),
                                        ),
                                        child: Text("Create new",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.white)))));
                          }
                        });
                  }

                  return CircularProgressIndicator();
                })));
  }
}
