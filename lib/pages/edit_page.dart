import 'dart:async';
import 'package:flutter_front/pages/validators/note_validator.dart';
import '../widgets/drawers/dynamic_auth_widget.dart';
import 'package:flutter/material.dart';
import '../dio.dart';
import '../models/post.dart';

class NoteEditPage extends StatelessWidget {
  String token;
  int id;
  NoteEditPage({super.key, required this.token, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Note')),
      body: NoteEditPageStateful(token: token, id: id),
    );
  }
}

class NoteEditPageStateful extends StatefulWidget {
  final String? token;
  final int? id;
  NoteEditPageStateful({super.key, this.token, this.id});

  @override
  State<NoteEditPageStateful> createState() =>
      _NoteEditPageStateful(token: token!, id: id!);
}

class _NoteEditPageStateful extends State<NoteEditPageStateful> {
  // controllers
  late TextEditingController nameController;
  late TextEditingController contentController;

// create focus nodes
  late FocusNode nameFocusNode;
  late FocusNode contentFocusNode;

  String token;
  int id;
  _NoteEditPageStateful({required this.token, required this.id});

  final Dio_Client _dio = Dio_Client();
  final NoteValidators noteValidator = NoteValidators();
  String? profileUpdateMessage;

  Future<AlertDialog?> updateNote(BuildContext context) async {
    String? message = await _dio.updateNote(
        content: contentController.text,
        name: nameController.text,
        id: id,
        token: widget.token!);
    print(message);

    AlertDialog alert = AlertDialog(
      title: const Text('Updating Note: '),
      content: Text(message!),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
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

  updatingTextEditingControllers(Post? noteInfo) {
    nameController.text = noteInfo!.name!;
    contentController.text = noteInfo!.content!;
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    contentController = TextEditingController();

    nameFocusNode = FocusNode();
    contentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    contentController.dispose();

    nameFocusNode.dispose();
    contentFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<Post?>(
              future: _dio.getNote(token: widget.token!, id: id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Post? noteInfo = snapshot.data;
                  if (noteInfo != null) {
                    updatingTextEditingControllers(noteInfo);
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
                                child: Icon(Icons.note, size: 100.0),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Note",
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
                      DynamicInputWidget(
                        controller: nameController,
                        obscureText: false,
                        focusNode: nameFocusNode,
                        toggleObscureText: null,
                        validator: noteValidator.nameValidator,
                        prefIcon: const Icon(Icons.abc),
                        labelText: "Enter note name",
                        textInputAction: TextInputAction.next,
                        isNonPasswordField: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                      ),
                      SizedBox(
                        height: 100,
                        child: DynamicInputWidget(
                            controller: contentController,
                            obscureText: false,
                            focusNode: contentFocusNode,
                            toggleObscureText: null,
                            validator: noteValidator.contentValidator,
                            prefIcon: const Icon(
                                Icons.drive_file_rename_outline_sharp),
                            labelText: "Enter content",
                            textInputAction: TextInputAction.next,
                            isNonPasswordField: true,
                            maxLines: 5,
                            minLines: 2),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      updateNote(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(3, 158, 162, 1),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                      minimumSize: Size(42, 42),
                                    ),
                                    child: Text("Update Note",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)),
                              )))
                    ]);
                  }
                }
                return CircularProgressIndicator();
              })),
    );
  }
}
