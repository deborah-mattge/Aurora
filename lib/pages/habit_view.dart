import 'package:aurora/controllers/HabitController.dart';
import 'package:aurora/models/Habit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graphic/graphic.dart';

void main() {
  runApp(MyApp3());
}

class MyApp3 extends StatelessWidget {
  final HabitController _habitController = HabitController();

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
  late List<Habit> habits = [];

  @override
  void initState() {
    super.initState();
    _fetchHabits();
  }

  Future<void> _fetchHabits() async {
    habits = await HabitController().getHabits(1);
    setState(() {});
  }

  DateTime _selectedValue = DateTime.now();

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
        textStyle: const TextStyle(fontSize: 14, color: Colors.black87),
        align: Alignment.topCenter,
      ),
    );
    return [titleElement];
  }

  @override
  Widget build(BuildContext context) {
    final List<String> itemColors = ["51B9D6", "FF4775", "7ACE78", "A26BD8"];
    var data = habits.map((habit) {
      return {'name': habit.name, 'color': habit.color, 'value': 10};
    }).toList();

    List<Color> habitColors = habits.map((habit) {
      String colorCode = habit.color ?? 'FFFFFF'; // Default to white if color is null
      if (colorCode.length == 6) {
        colorCode = '0xFF' + colorCode;
      }
      try {
        return Color(int.parse(colorCode));
      } catch (e) {
        return Colors.grey; // Default to grey if parsing fails
      }
    }).toList();

    Color singleColor = habitColors.isNotEmpty ? habitColors.first : Colors.grey;
    List<Color> colorValues = habitColors.length > 1 ? habitColors : [singleColor, singleColor];

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
            icon: const Icon(Icons.person, color: Color.fromRGBO(81, 185, 214, 1)),
          ),
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
                  offset: const Offset(15, 0),
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
              dateTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              dayTextStyle: const TextStyle(fontSize: 10),
              monthTextStyle: const TextStyle(fontSize: 10),
              onDateChange: (date) {
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
                  offset: const Offset(15, 0),
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
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: HabitList(habits: habits),
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
                                fontWeight: FontWeight.w600,
                              ),
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
                                accessor: (Map map) => map['color'] as String,
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
                                  variable: 'color', values: colorValues),
                                modifiers: [StackModifier()],
                              ),
                            ],
                            coord: PolarCoord(
                              transposed: true,
                              dimCount: 1,
                              startRadius: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: CarouselSlider(
              items: PeriodLabel.values.map((e) {
                int index = PeriodLabel.values.indexOf(e);
                Color color = Color(int.parse(
                  "0xFF${itemColors[index % itemColors.length]}"));
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: color,
                      ),
                      child: Center(
                        child: Text(
                          e.toString().split('.').last.toLowerCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 0),
                    Container(
                      margin: const EdgeInsets.only(top: 20, right: 5, left: 5),
                      child: Slidable(
                        startActionPane: ActionPane(motion: BehindMotion(), children: [
                          SlidableAction(
                            onPressed: ((context) {}),
                            backgroundColor: Colors.pink,
                            icon: Icons.add,
                            padding: const EdgeInsets.all(0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.elliptical(10.0, 10.0),
                              bottomLeft: Radius.elliptical(10.0, 10.0),
                            ),
                          ),
                          SlidableAction(
                            onPressed: ((context) {}),
                            backgroundColor: const Color.fromRGBO(81, 185, 214, 1),
                            foregroundColor: Colors.white,
                            icon: Icons.check,
                          ),
                        ]),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(15, 0),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: color,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: Text(
                                  e.toString().split('.').last.toLowerCase(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                height: 150,
                enableInfiniteScroll: false,
                viewportFraction: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HabitList extends StatelessWidget {
   final List<Habit> habits;

  HabitList({required this.habits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,  
      itemCount: habits.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(habits[index].name),
        );
      },
    );
  }
}

class Habit {
  String name;
  String color;

  Habit({required this.name, required this.color});
}

class HabitController {
  Future<List<Habit>> getHabits(int userId) async {
    // Simulating a network call with dummy data
    await Future.delayed(Duration(seconds: 2));
    return [
      Habit(name: 'Exercise', color: '51B9D6'),
      Habit(name: 'Read', color: 'FF4775'),
      Habit(name: 'Meditate', color: '7ACE78'),
    ];
  }
}
