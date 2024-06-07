import 'package:aurora/components/decoration_button.dart';
import 'package:aurora/components/decoration_input.dart';
import 'package:flutter/material.dart';

class Create extends StatelessWidget {
  const Create({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Post Example',
      home: MyHomePage2(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage2 extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  DateTime initialDate = DateTime(2024, 05, 03);
  DateTime finishDate = DateTime(2024, 06, 30);

  final controller = TextEditingController();

  final dropValue = ValueNotifier('');
  final dropOptions = ['Sim/Não', 'Quantidade'];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  Color _colorTag = const Color.fromRGBO(162, 107, 216, 1);
  late int numberColor = 1;

  void changeColorRight() {
    setState(() {
      if (numberColor == 1) {
        _colorTag = const Color.fromRGBO(61, 170, 243, 0.522);
        numberColor = 2;
      } else if (numberColor == 2) {
        _colorTag = const Color.fromRGBO(255, 71, 117, 1);
        numberColor = 3;
      } else if (numberColor == 3) {
        _colorTag = const Color.fromRGBO(163, 221, 197, 1);
        numberColor = 4;
      }
    });
  }

  void changeColorLeft() {
    setState(() {
      if (numberColor == 2) {
        _colorTag = const Color.fromRGBO(162, 107, 216, 1);
        numberColor = 1;
      } else if (numberColor == 4) {
        _colorTag = const Color.fromRGBO(255, 71, 117, 1);
        numberColor = 3;
      } else if (numberColor == 3) {
        _colorTag = const Color.fromRGBO(61, 170, 243, 1);
        numberColor = 2;
      }
    });
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
                padding: EdgeInsets.only(top: 20.0),
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
                    const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // INPUT NOME
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
                    // ESCOLHA O TEXTINHO
                    Container(
                      height: 40,
                      child: TextField(
                        decoration: getHabitInputDecorations(
                          sendText: 'Ex: Beber água',
                          vertical: 8,
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
                              SizedBox(
                                width: 130,
                                height: 40,
                                child: ValueListenableBuilder<String>(
                                  valueListenable: dropValue,
                                  builder:
                                      (BuildContext context, String value, _) {
                                    return DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                31, 136, 136, 136),
                                            width: 1,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 252, 250, 250),
                                      ),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color:
                                            Color.fromARGB(255, 79, 196, 248),
                                        size: 25,
                                      ),
                                      hint: const Text('Tipo'),
                                      value: (value.isEmpty) ? null : value,
                                      onChanged: (choice) =>
                                          dropValue.value = choice.toString(),
                                      items: dropOptions.map((op) {
                                        return DropdownMenuItem(
                                          value: op,
                                          child: Text(
                                            op,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(88, 88, 88, 1),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
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
                                  height: 40,
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
                      padding: const EdgeInsets.only(top: 20.0),
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
                                      // ESCOLHA UMA TAG
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
                                        onPressed: changeColorLeft,
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
                                          // SETA AZUL 1º
                                          Icons.keyboard_arrow_left,
                                          color:
                                              Color.fromARGB(255, 79, 196, 248),
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      child: ElevatedButton(
                                        onPressed: changeColorRight,
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
                                          // SETA AZUL 2º
                                          Icons.keyboard_arrow_right,
                                          color:
                                              Color.fromARGB(255, 79, 196, 248),
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 60,
                                      top: 10,
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // BOLA COLORIDA
                                          color: _colorTag,
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
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
                              SizedBox(width: 163),
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

                          // Botões de calendário
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: getHabitButtonDecorations(),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Início",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(74, 74, 73, 1),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: Color.fromRGBO(255, 71, 117, 1),
                                      size: 18,
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  DateTime? newInitialDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (newInitialDate == null) return;
                                  setState(() => initialDate = newInitialDate);
                                },
                              ),
                              ElevatedButton(
                                style: getHabitButtonDecorations(),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Fim",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(74, 74, 73, 1),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: Color.fromRGBO(255, 71, 117, 1),
                                      size: 18,
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  DateTime? newFinishDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: finishDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (newFinishDate == null) return;
                                  setState(() => finishDate = newFinishDate);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          // INPUT SELECIONE
                          Text(
                            'Selecione',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(74, 74, 73, 1),
                            ),
                          ),
                          SizedBox(width: 2, height: 2),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(246, 255, 123, 156)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'matutino',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(122, 206, 120, 235)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'vespertino',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(232, 129, 199, 235)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'noturno',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(161, 149, 243, 191),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'diário',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(30, 15)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(110, 25)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(255, 71, 117, 1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'cancelar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(30, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(110, 25)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(81, 185, 214, 1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'salvar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
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
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
    );
  }
}
