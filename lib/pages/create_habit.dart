import 'package:aurora/components/decoration_button.dart';
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
  DateTime initialDate = DateTime(2024, 05, 03);
  DateTime finishDate = DateTime(2024, 06, 30);

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
      body: SingleChildScrollView(
        child: Padding(
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
                    Container(
                      height: 35, // Ajuste para testar diferentes alturas.
                      child: TextField(
                        decoration: getHabitInputDecorations(
                          sendText: 'Ex: Beber água',
                          vertical: 8, // Reduzido para o mínimo possível.
                          horizontal: 15,
                          width: 0,
                        ),
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
                                builder:
                                    (BuildContext context, String value, _) {
                                  return DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          fontSize: 15, color: Colors.black38),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 252, 250, 250),
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
                                child: Container(
                                  height: 35,
                                  child: TextField(
                                    decoration: getHabitInputDecorations(
                                      sendText: 'Ex: Litros',
                                      vertical: 10,
                                      horizontal: 10,
                                      width: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 40,
                                child: Stack(
                                  children: [
                                    const Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: Text(
                                        "Escolha uma tag",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(74, 74, 73, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 75,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print("Clicou");
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      245, 245, 245, 1.0)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      245, 245, 245, 1.0)),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Colors.transparent;
                                              }
                                              return null;
                                            },
                                          ),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero),
                                        ),
                                        child: const Icon(
                                          Icons.keyboard_arrow_left,
                                          color:
                                              Color.fromARGB(255, 79, 196, 248),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 60,
                                      top: 10,
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(162, 107, 216, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: getHabitButtonDecorations(),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Início",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(74, 74, 73, 1))),
                                SizedBox(width: 20),
                                Icon(Icons.calendar_today_rounded,
                                    color: Color.fromRGBO(255, 71, 117, 1),
                                    size: 18),
                              ],
                            ),
                            onPressed: () async {
                              DateTime? newInitialDate = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              if (newInitialDate == null) return;
                              setState(() => initialDate = newInitialDate);
                            },
                          ),
                          ElevatedButton(
                            style: getHabitButtonDecorations(),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Fim",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(74, 74, 73, 1))),
                                SizedBox(width: 20),
                                Icon(Icons.calendar_today_rounded,
                                    color: Color.fromRGBO(255, 71, 117, 1),
                                    size: 18),
                              ],
                            ),
                            onPressed: () async {
                              DateTime? newFinishDate = await showDatePicker(
                                  context: context,
                                  initialDate: finishDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              if (newFinishDate == null) return;
                              setState(() => finishDate = newFinishDate);
                            },
                          ),
                        ],
                      ),
                    ),
                    //AQUI
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Text(
                            'Selecione',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(74, 74, 73, 1),
                            ),
                          ),
                          SizedBox(width: 1, height: 2),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
    );
  }
}
