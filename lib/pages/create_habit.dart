import 'package:aurora/components/decoration_input.dart';
import 'package:flutter/material.dart';

class Create extends StatelessWidget {
  const Create({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Post Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AURORA'),
          backgroundColor: const Color.fromRGBO(61, 170, 243, 0.522),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Text(
                    'Novo Hábito',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(74, 74, 73, 1)),
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Nome',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(74, 74, 73, 1)),
                          ),
                          SizedBox(width: 3),
                          Text(
                            '*',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(255, 71, 117, 1)),
                          ),
                        ],
                      ),
                      TextField(
                        decoration: getHabitInputDecorations(
                            sendText: 'Ex: Beber água',
                            vertical: 10,
                            horizontal: 15,
                            width: 0),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '*',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(255, 71, 117, 1)),
                            )
                          ]),
                      TextField(
                        decoration: getHabitInputDecorations(
                            sendText: 'Tipo',
                            vertical: 10,
                            horizontal: 10,
                            width: 5),
                      )
                    ],
                  ))
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0));
  }
}
