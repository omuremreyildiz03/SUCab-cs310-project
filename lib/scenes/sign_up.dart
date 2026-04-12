import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String _name = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(100, 100, 100, 200),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Sign Up"),
        ),
        body: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("SuCab", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: "Enter SU-id name: ",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
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
                      filled: true,
                      fillColor: Colors.white,
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
                    child: Text("Sign up")
                ),
              ],
            )
        )
    );
  }
}
