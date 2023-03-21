import '/pages/auth_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auth')),
      body:
          // Safe area prevents safe gards widgets to go beyond device edges
          SafeArea(
        //===========//
        // to dismiss keyword on tap outside use listener
        child: Listener(
          onPointerDown: (PointerDownEvent event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          //===========//
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(children: [
                // Display a welcome user image
                const AuthFormWidget()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
