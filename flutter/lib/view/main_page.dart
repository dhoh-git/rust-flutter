import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:score/model/user.dart';
import 'package:score/view/painter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;
  User user = User(1,'a');

  void _incrementCounter() {
    setState(() {
      _counter++;
      print(user.name);
      user.name='b';
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    );
    final _body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            '넌 버튼을 몇 번 눌렀냐면... :',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
              onPressed: (){
                /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>const SecondPage())
                );*/
                context.go('/second');
              },
              child: const Text('두번째 화면')
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>PainterPage())
                );
                //context.go('/painter');
              },
              child: const Text('차트')
          ),
        ],
      ),
    );
    final _floatingActButton = FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),

    );
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActButton, // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
