import 'package:aurora/models/ENUM/habit_category.dart';
import 'package:aurora/models/Habit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:graphic/graphic.dart';
import 'dart:ui';

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'User Post Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedValue = DateTime.now();
  List<Habit> habits = [
    Habit(
        id: 1,
        name: 'Exercise',
        habitCategory: HabitCategory.AFTERNOON,
        color: 'FF4775'),
    Habit(
        id: 2,
        name: 'Reading',
        habitCategory: HabitCategory.MORNING,
        color: '51B9D6'),
    Habit(
        id: 3,
        name: 'Meditation',
        habitCategory: HabitCategory.EVENING,
        color: 'A26BD8'),
    Habit(
        id: 4,
        name: 'Healthy Eating',
        habitCategory: HabitCategory.EVERYDAY,
        color: '7ACE78'),
  ];
  List<MarkElement> centralPieLabel(
    Size size,
    Offset anchor,
    Map<int, Tuple> selectedTuples,
  ) {
    final tuple = selectedTuples.values.last;

    final titleElement = LabelElement(
        text: 'olaaa',
        anchor: const Offset(175, 150),
        style: LabelStyle(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            align: Alignment.topCenter));

    return [titleElement];
  }

  @override
  Widget build(BuildContext context) {
    final List<String> itemColors = [
      "51B9D6",
      "FF4775",
      "7ACE78",
      "A26BD8",
    ];
    var data = habits.map((habit) {
      return {
        'name': habit.name,
        'color': habit.color,
        'value': 10
      }; // Inicialize o valor como 0
    }).toList();
    List<Color> habitColors =
        habits.map((habit) => Color(int.parse('0xFF${habit.color}'))).toList();

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 25.0),
          child: SizedBox(
            child: Image.asset('assets/images/AURORA.png'),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Color.fromRGBO(81, 185, 214, 1),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(15, 0), // changes position of shadow
                ),
              ],
            ),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              width: 49,
              height: 90,
              locale: "pt_BR",
              selectionColor: const Color.fromRGBO(81, 185, 214, 1),
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              dayTextStyle: const TextStyle(
                fontSize: 10,
              ),
              monthTextStyle: const TextStyle(
                fontSize: 10,
              ),
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
              },
            ),
          ),
          Container(
            width: 429,
            height: 200,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(15, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Progresso diário",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(81, 185, 214, 1),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      height: 100,
                      child: HabitList(
                        habits: habits,
                      ),
                    ),
                    Stack(
                      children: [
                        const Positioned.fill(
                          child: Center(
                            child: Text(
                              '1/3',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.pink,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 152,
                          height: 130,
                          child: Chart(
                            data: data,
                            variables: {
                              'name': Variable(
                                accessor: (Map map) => map['name'] as String,
                              ),
                              'value': Variable(
                                accessor: (Map map) => map['value'] as num,
                              ),
                              'color': Variable(
                                // Adicione uma variável para a cor
                                accessor: (Map map) => map['color']
                                    as String, // O accessor retorna a cor como uma String
                              ),
                            },
                            transforms: [
                              Proportion(
                                variable: 'value',
                                as: 'percent',
                              )
                            ],
                            marks: [
                              IntervalMark(
                                position: Varset('percent') / Varset('name'),
                                color: ColorEncode(
                                  variable: 'color',
                                  values: data
                                      .map((e) =>
                                          Color(int.parse('0xFF${e['color']}')))
                                      .toList(),
                                  // Convertendo a cor hexadecimal para Color
                                ),
                                modifiers: [StackModifier()],
                              )
                            ],
                            coord: PolarCoord(
                              transposed: true,
                              dimCount: 1,
                              startRadius: 0.8,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: CarouselSlider(
              items: HabitCategory.values.map((e) {
                int index = HabitCategory.values.indexOf(e);
                Color color = Color(int.parse(
                    "0xFF${itemColors[index % itemColors.length]}")); // Selecionando a cor correspondente ao item
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: color,
                      ),
                      child: Center(
                        child: Text(
                          e
                              .toString()
                              .split('.')
                              .last
                              .toLowerCase(), // Removendo o prefixo HabitCategory
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors
                                .white, // Você pode ajustar a cor do texto conforme necessário
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      color: color,
                    )
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                height: 300,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {}
}

class Graphic extends StatelessWidget {
  const Graphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Chart(
      data: const [
        {'genre': 'Sports', 'sold': 275},
        {'genre': 'Strategy', 'sold': 115},
        {'genre': 'Action', 'sold': 120},
        {'genre': 'Shooter', 'sold': 350},
        {'genre': 'Other', 'sold': 150},
      ],
      variables: {
        'genre': Variable(
          accessor: (Map map) => map['genre'] as String,
        ),
        'sold': Variable(
          accessor: (Map map) => map['sold'] as num,
        ),
      },
      marks: [IntervalMark()],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    );
  }
}

class HabitList extends StatelessWidget {
  final List<Habit> habits;

  HabitList({required this.habits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: habits.length,
      itemExtent: 25,
      itemBuilder: (context, index) {
        final habit = habits[index];
        return Container(
          child: Row(
            children: [
              Container(
                width: 8, // Largura do círculo
                height: 8, // Altura do círculo
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Color(int.parse('0xFF${habit.color}')), // Cor do hábito
                ),
              ),
              SizedBox(width: 8),
              Text(habit.name),
            ],
          ),
          // Você pode adicionar mais personalizações aqui
        );
      },
    );
  }
}
