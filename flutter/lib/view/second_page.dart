import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondPage extends StatelessWidget{
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: ElevatedButton(
          child: const Text('go home'),
          onPressed: (){
            //Navigator.pop(context);
            context.go('/');
          },
        )
      )
    );
  }

}