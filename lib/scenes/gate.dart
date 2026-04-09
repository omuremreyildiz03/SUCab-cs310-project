import 'package:flutter/material.dart';

class GateScreen extends StatefulWidget {
  const GateScreen({super.key});

  @override
  State<GateScreen> createState() => _GateScreenState();
}

class _GateScreenState extends State<GateScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gate"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("This is Gate"),
          ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/tickets');}, child: Icon(Icons.home))
        ],
      ),
    );
  }
}