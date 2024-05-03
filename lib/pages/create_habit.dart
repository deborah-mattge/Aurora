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

  final dropValue = ValueNotifier('');
  final dropOptions = ['Sim/Não', 'Quantidade', 'Tempo'];

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
                    color: Color.fromRGBO(74, 74, 73, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(74, 74, 73, 1),
                        ),
                      ),
                      SizedBox(width: 3, height: 2),

                      // Nome do hábito
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 71, 117, 1),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    // INPUT 'NOME'
                    decoration: getHabitInputDecorations(
                      sendText: 'Ex: Beber água',
                      vertical: 10,
                      horizontal: 15,
                      width: 0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 71, 117, 1),
                        ),
                      ),
                      SizedBox(width: 159),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 71, 117, 1),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 0),
                            Expanded(
                                child: ValueListenableBuilder<String>(
                              valueListenable: dropValue,
                              builder: (BuildContext context, String value, _) {
                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        fontSize: 15, color: Colors.black38),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.black12,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color.fromARGB(255, 79, 196, 248),
                                    size: 25,
                                  ),
                                  hint: const Text('Tipo'),
                                  value: (value.isEmpty) ? null : value,
                                  onChanged: (choice) =>
                                      dropValue.value = choice.toString(),
                                  items: dropOptions
                                      .map((op) => DropdownMenuItem(
                                            value: op,
                                            child: Text(
                                              op,
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      88, 88, 88, 1)),
                                            ),
                                          ))
                                      .toList(),
                                );
                              },
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 0),
                            Expanded(
                              // INPUT 'EX: LITROS'
                              child: TextField(
                                decoration: getHabitInputDecorations(
                                  sendText: 'Ex: Litros',
                                  vertical: 10,
                                  horizontal: 10,
                                  width: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              const Text(
                                "Escolha uma tag",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(74, 74, 73, 1),
                                ),
                              ),
                              const Positioned(
                                bottom: -1,
                                left: 125.2,
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(255, 71, 117, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 114,
                                top: 3,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 79, 196, 248),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 86,
                                top: 3,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(255, 71, 117, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 58,
                                top: 3,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(122, 206, 120, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 30,
                                top: 3,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(162, 107, 216, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 3,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
    );
  }
}
