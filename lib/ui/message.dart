import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
        child: Text("GOOD JOB", style: TextStyle(fontSize: 50.0, color: Colors.green, fontWeight: FontWeight.bold),),
      )
    );
  }
}