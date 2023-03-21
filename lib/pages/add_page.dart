import 'dart:async';
import 'package:flutter_front/models/category.dart';
import 'package:flutter_front/pages/validators/note_validator.dart';
import 'package:flutter/material.dart';
import '../dio.dart';
import '../widgets/drawers/dynamic_auth_widget.dart';

class NoteAddPage extends StatelessWidget {
  String token;
  NoteAddPage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: NoteAddPageStateful(token: token),
    );
  }
}

class NoteAddPageStateful extends StatefulWidget {
  final String? token;
  NoteAddPageStateful({super.key, this.token});

  @override
  State<NoteAddPageStateful> createState() =>
      _NoteAddPageStateful(token: token!);
}

class _NoteAddPageStateful extends State<NoteAddPageStateful> {
  // controllers
  late TextEditingController nameController;
  late TextEditingController contentController;

// create focus nodes
  late FocusNode nameFocusNode;
  late FocusNode contentFocusNode;

  String token;
  _NoteAddPageStateful({required this.token});

  final Dio_Client _dio = Dio_Client();
  final NoteValidators noteValidator = NoteValidators();

  List<int>? _categoriesId;
  List<String>? _categoriesName;

  List<Category>? categories;

  List<String> _countrycodes = ["+65", "+91"];
  List<String> _colors = ['', 'red', 'green', 'blue', 'orange'];

  String? _selectedCategory;
  int? _selectedCategoryId;
  String _color = '';

  Future<AlertDialog?> addNote(BuildContext context) async {
    String? message = await _dio.createNote(
        content: contentController.text,
        name: nameController.text,
        token: widget.token!,
        categoryId: _selectedCategoryId!);
    print(message);

    AlertDialog alert = AlertDialog(
      title: const Text('Creating Note: '),
      content: Text(message!),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
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

  fillingDropdown(List<Category> categories) {
    for (var i = 0; i < categories.length; i++) {
      _categoriesId?.add(categories[i].id!);
      _categoriesName?.add(categories[i].categoryName!);
    }
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
      child: FutureBuilder<List<Category>?>(
          future: _dio.getCategories(token: widget.token!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              categories = snapshot.data;
              if (categories != null) {
                fillingDropdown(categories!);
                return Column(children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(156, 152, 140, 1),
                          border: Border.all(
                            color: Color.fromRGBO(156, 152, 140, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Icon(Icons.note, size: 100.0),
                      ),
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
                        color: Colors.grey, width: double.infinity, height: 1),
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
                        prefIcon:
                            const Icon(Icons.drive_file_rename_outline_sharp),
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
                  DropdownButton(
                    hint: Text(_selectedCategory ?? "Category"),
                    value: _selectedCategoryId,
                    items: categories!
                        .map((category) => new DropdownMenuItem(
                            value: category.id,
                            child: new Text(category.categoryName!)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedCategory = categories!
                            .singleWhere((element) => element.id == val)
                            .categoryName;
                        _selectedCategoryId = val;
                      });
                    },
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  addNote(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(3, 158, 162, 1),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: Size(42, 42),
                                ),
                                child: Text("Create Note",
                                    style:
                                        Theme.of(context).textTheme.bodyText1)),
                          )))
                ]);
              }
            }
            return CircularProgressIndicator();
          }),
    ));
  }
}
