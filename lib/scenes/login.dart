import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _remember_me = false;
  String _name = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is login")),
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
                Row(
                  children: [
                    Text("Remember me"),
                    Checkbox(
                        value: _remember_me,
                        onChanged: (bool? value) {
                          setState(() {
                            _remember_me = value ?? false;
                          });
                        }
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()){
                        _formkey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$_name successfully logged in."))
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
                    child: Text("Login")
                ),
              ],
            )
        )
    );
  }
}