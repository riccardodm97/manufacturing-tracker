import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Log In'),
              backgroundColor: Colors.grey[900],
            ),
            body: Container(
                color: Colors.grey[800],
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Welcome to Food Traceability App',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: TextField(
                            controller: loginController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              labelText: 'Private key',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: model.busy
                            ? const CircularProgressIndicator()
                            : FloatingActionButton.extended(
                                heroTag: "login_button",
                                onPressed: () {
                                  // model.login(context, loginController.text);
                                },
                                backgroundColor: Colors.red[400],
                                icon: const Icon(Icons.login),
                                label: const Text('Log In')),
                      ),
                    ])))));
  }
}
