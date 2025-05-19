import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:score/model/score.dart';

class SecondPage extends StatelessWidget{
  Score? score;
  SecondPage({super.key, required this.score});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Column(
            children: <Widget>[
              ElevatedButton(
                child: const Text('go home'),
                onPressed: (){
                  //Navigator.pop(context);
                  context.go('/');
                },
              ),
              Text(
                '${score!.scores?[2]}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ]
          )

      )
    );
  }

}