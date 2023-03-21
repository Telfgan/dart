import 'package:flutter_front/dio.dart';
import 'package:flutter_front/settings/utils/router_utils.dart';
import 'package:flutter_front/pages/profile_edit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/pages/profile_edit.dart';
import 'package:go_router/go_router.dart';

import '../dio.dart';
import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  String token;
  ProfilePage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePageStateful(token: token),
    );
  }
}

class ProfilePageStateful extends StatefulWidget {
  final String? token;
  ProfilePageStateful({super.key, this.token});

  @override
  State<ProfilePageStateful> createState() =>
      _ProfilePageStateful(token: token!);
}

class _ProfilePageStateful extends State<ProfilePageStateful> {
  String token;
  _ProfilePageStateful({required this.token});

  final Dio_Client _client = Dio_Client();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<User?>(
              future: _client.getProfile(token: widget.token!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? userInfo = snapshot.data;
                  if (userInfo != null) {
                    return Column(children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(156, 152, 140, 1),
                                border: Border.all(
                                  color: Color.fromRGBO(156, 152, 140, 1),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Expanded(
                                child: Icon(Icons.account_box, size: 100.0),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("User profile",
                                  style: Theme.of(context).textTheme.headline2))
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        child: Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 1),
                      ),

                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(3, 158, 162, 1),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: Size(42, 42),
                                ),
                                child: Icon(
                                  Icons.email,
                                  size: 20,
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 13, right: 120),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${userInfo.email}",
                                        style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17.0,
                                          color: Colors.black,
                                        )),
                                    const Text("E-mail",
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                        ))
                                  ],
                                )),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, right: 10, left: 10),
                        child: Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 1),
                      ),

                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(3, 158, 162, 1),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: Size(42, 42),
                                ),
                                child: Icon(
                                  Icons.man,
                                  size: 20,
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 13, right: 120),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${userInfo.userName}",
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17.0,
                                          color: Colors.black,
                                        )),
                                    Text("User name",
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                        ))
                                  ],
                                )),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        child: Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 1),
                      ),

                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ProfilePageEdit(
                                              token: widget.token!);
                                        },
                                      ));
                                      // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(3, 158, 162, 1),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                      minimumSize: Size(42, 42),
                                    ),
                                    child: Text("Update profile",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)),
                              )))
                      // SizedBox(height: 8.0),
                      // Text(
                      //   '${userInfo.userName} ${userInfo.email}',
                      //   style: TextStyle(fontSize: 16.0),
                      // )
                    ]);
                  }
                }
                return CircularProgressIndicator();
              })),
    );
  }
}
