import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import 'package:score/view/pie_chart.dart';

//https://software-creator.tistory.com/23
class PainterPage extends StatelessWidget {
  final List<double> points = [50, 0, 73, 100,150, 120, 200, 80];

  PainterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart Page"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.orange,
                padding: const EdgeInsets.all(20),
                child: CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                  size: const Size(150, 150), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                  painter: PieChart(percentage: 20, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
                      textScaleFactor: 1.0, // 파이 차트에 들어갈 텍스트 크기를 정합니다.
                      textColor: Colors.blueGrey),
                ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Container(
                color: Colors.indigoAccent,
                padding: const EdgeInsets.all(20),
                child:ElevatedButton(
                  child: const Text('go home'),
                  onPressed: (){
                    Navigator.pop(context);
                    //context.go('/');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }}
