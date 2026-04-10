import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String _name = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("This is sign in")),
        body: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: "Enter SU-id name: ",
                      border: OutlineInputBorder(),
                      suffix: IconButton(
                          onPressed: () {
                            _nameController.clear();
                          },
                          icon: Icon(Icons.clear)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field cannot be empty";
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter Su-id password: ",
                      border: OutlineInputBorder(),
                      suffix: IconButton(
                          onPressed: () {
                            _passwordController.clear();
                          },
                          icon: Icon(Icons.clear)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field cannot be empty";
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()){
                        _formkey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$_name successfully signed in."))
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/profile',
                              (route) => false,
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Not valid!"))
                        );
                      }
                    },
                    child: Text("Sign in")
                ),
              ],
            )
        )
    );
  }
}