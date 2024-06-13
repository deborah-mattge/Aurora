import 'package:aurora/components/decoration_button.dart';
import 'package:aurora/components/decoration_input.dart';
import 'package:aurora/controllers/HabitController.dart';
import 'package:aurora/models/Habit.dart';
import 'package:aurora/pages/habit_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String habitName = '';
  String categoria = 'Tipo';
  String reference = '';
  String habitColor = '#ffa26bd8';
  String meta = '';
  DateTime initialDate = DateTime(2024, 06, 07);
  late DateTime finishDate;

  bool isMatutinoSelected = false;
  bool isVespertinoSelected = false;
  bool isNoturnoSelected = false;
  bool isDiarioSelected = false;

  final controller = TextEditingController();

  final dropValue = ValueNotifier('');
  final dropOptions = ['Sim/Não', 'Quantidade'];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
    finishDate = DateTime.now();
  }

  Future<void> selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: finishDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != finishDate) {
      setState(() {
        finishDate = picked;
      });
    }
  }

  Color _colorTag = const Color.fromRGBO(162, 107, 216, 1);
  late int numberColor = 1;

 void changeColorRight() {
    setState(() {
      if (numberColor == 1) {
        _colorTag = const Color.fromRGBO(61, 170, 243, 0.522);
        habitColor = "#ff51b9d6";
        numberColor = 2;
      } else if (numberColor == 2) {
        _colorTag = const Color.fromRGBO(255, 71, 117, 1);
        habitColor = "#ffff4775";
        numberColor = 3;
      } else if (numberColor == 3) {
        _colorTag = const Color.fromRGBO(163, 221, 197, 1);
        habitColor = "#ff7ace78";
        numberColor = 4;
      }
    });
  }

  void changeColorLeft() {
    setState(() {
      if (numberColor == 2) {
        _colorTag = const Color.fromRGBO(162, 107, 216, 1);
        habitColor = "#ffa26bd8";
        numberColor = 1;
      } else if (numberColor == 4) {
        _colorTag = const Color.fromRGBO(255, 71, 117, 1);
        habitColor = "#ffff4775";
        numberColor = 3;
      } else if (numberColor == 3) {
        _colorTag = const Color.fromRGBO(61, 170, 243, 0.522);
        habitColor = "#ff51b9d6";
        numberColor = 2;
      }
    });
  }

  late String date;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      date = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void saveHabit() {
    debugPrint("entrei para criar");

    PeriodLabel periodLabel;
    TypeLabel typeLabel;

    if (isMatutinoSelected) {
      periodLabel = PeriodLabel.matutino;
      isMatutinoSelected = false;
    } else if (isNoturnoSelected) {
      periodLabel = PeriodLabel.noturno;
      isNoturnoSelected = false;
    } else if (isVespertinoSelected) {
      periodLabel = PeriodLabel.vespertino;
      isVespertinoSelected = false;
    } else if (isDiarioSelected) {
      periodLabel = PeriodLabel.diario;
      isDiarioSelected = false;
    } else {
      periodLabel = PeriodLabel.diario;
    }

    if (categoria == "Quantidade") {
      typeLabel = TypeLabel.quantidade;
    } else {
      typeLabel = TypeLabel.booleano;
    }

    print(periodLabel);
    String data = finishDate.toString();
    HabitController().postHabits(
        habitName, habitColor, typeLabel, periodLabel, reference, date, meta);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp3()),
    );
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
                padding: EdgeInsets.only(top: 40.0),
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
                    const EdgeInsets.only(top: 60.0, left: 25.0, right: 25.0),
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
                        onChanged: (value) {
                          setState(() {
                            habitName = value;
                          });
                        },
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
                                width: 140,
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
                                      onChanged: (choice) => setState(() {
                                        categoria = choice!;
                                        dropValue.value = choice.toString();
                                      }),
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
                                    onChanged: (value) {
                                      setState(() {
                                        reference = value;
                                      });
                                    },
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
                                      right: 55,
                                      top: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (categoria ==
                              'Quantidade') // Condição para mostrar apenas se for 'Quantidade'
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Meta diária',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(74, 74, 73, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(255, 71, 117, 1),
                                          ),
                                        ),
                                        SizedBox(width: 70),
                                        Text(
                                          'Data final',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(74, 74, 73, 1),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(255, 71, 117, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 40,
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            meta = value;
                                          });
                                        },
                                        decoration: getHabitInputDecorations(
                                          sendText: 'Ex: 4',
                                          vertical: 10,
                                          horizontal: 10,
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    ElevatedButton(
                                      style: getHabitButtonDecorations(),
                                      onPressed: () => selectDate(context),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${finishDate.day}/${finishDate.month}/${finishDate.year}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromRGBO(74, 74, 73, 1),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            color:
                                                Color.fromRGBO(255, 71, 117, 1),
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (categoria == 'Tipo' || categoria == "Sim/Não")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Data final',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(74, 74, 73, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(255, 71, 117, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: getHabitButtonDecorations(),
                                      onPressed: () => selectDate(context),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${finishDate.day}/${finishDate.month}/${finishDate.year}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromRGBO(74, 74, 73, 1),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            color:
                                                Color.fromRGBO(255, 71, 117, 1),
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                            margin: const EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isMatutinoSelected = !isMatutinoSelected;
                                  if (isMatutinoSelected) {
                                    isVespertinoSelected = false;
                                    isNoturnoSelected = false;
                                    isDiarioSelected = false;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  final bool isPressed =
                                      states.contains(MaterialState.pressed);
                                  final bool isSelected = isMatutinoSelected;

                                  const Color defaultColor =
                                      Color.fromARGB(246, 255, 123, 156);
                                  const Color selectedColor =
                                      Color.fromRGBO(255, 71, 117, 1);

                                  return isSelected
                                      ? selectedColor
                                      : defaultColor;
                                }),
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
                            margin: const EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isVespertinoSelected = !isVespertinoSelected;
                                  if (isVespertinoSelected) {
                                    isMatutinoSelected = false;
                                    isNoturnoSelected = false;
                                    isDiarioSelected = false;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  final bool isSelected = isVespertinoSelected;

                                  const Color defaultColor =
                                      Color.fromARGB(122, 206, 120, 235);
                                  const Color selectedColor =
                                      Color.fromRGBO(162, 107, 216, 1);

                                  return isSelected
                                      ? selectedColor
                                      : defaultColor;
                                }),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isNoturnoSelected = !isNoturnoSelected;
                                  if (isNoturnoSelected) {
                                    isMatutinoSelected = false;
                                    isVespertinoSelected = false;
                                    isDiarioSelected = false;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  final bool isSelected = isNoturnoSelected;

                                  const Color defaultColor =
                                      Color.fromARGB(232, 129, 199, 235);
                                  const Color selectedColor =
                                      Color.fromRGBO(32, 166, 255, 0.522);

                                  return isSelected
                                      ? selectedColor
                                      : defaultColor;
                                }),
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
                              onPressed: () {
                                setState(() {
                                  isDiarioSelected = !isDiarioSelected;
                                  if (isDiarioSelected) {
                                    isMatutinoSelected = false;
                                    isVespertinoSelected = false;
                                    isNoturnoSelected = false;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 20)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 28)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  final bool isSelected = isDiarioSelected;

                                  const Color defaultColor =
                                      Color.fromRGBO(163, 221, 197, 1);
                                  const Color selectedColor =
                                      Color.fromARGB(160, 100, 255, 170);

                                  return isSelected
                                      ? selectedColor
                                      : defaultColor;
                                }),
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
                            margin: const EdgeInsets.only(top: 60),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navegar para a tela habit_view.dart
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp3()),
                                );
                              },
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
                            margin: const EdgeInsets.only(top: 60),
                            child: ElevatedButton(
                              onPressed: saveHabit,
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
