import 'package:aurora/controllers/DailyGoalController.dart';
import 'package:aurora/controllers/HabitController.dart';
import 'package:aurora/modals/daily_goal_modal.dart';
import 'package:aurora/modals/habits_modal.dart';
import 'package:aurora/modals/update_user_modal.dart';
import 'package:aurora/modals/success_alert.dart' as alert;
import 'package:aurora/models/DailyGoal.dart';
import 'package:aurora/models/Habit.dart';
import 'package:aurora/pages/create_habit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp3());
}

class MyApp3 extends StatelessWidget {
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
  late DailyGoal dailyGoal;
  late List<DailyGoal> dailies;
  late num dailiesLenght = 2;
  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchHabits();
  }

  Future<void> _fetchHabits() async {
    habits = await HabitController().getHabits(1);
    dailyGoal = await DailyGoalController()
        .getByDay2(_selectedValue.day, _selectedValue.month, 1);
    setState(() {});
    DateTime dateTime = _selectedValue;
    dailies =
        await DailyGoalController().getAllByDay(dateTime.day, dateTime.month);
    dailiesLenght = dailies.length;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> itemColors = ["51B9D6", "FF4775", "7ACE78", "A26BD8"];
    var data = habits.map((habit) {
      return {'name': habit.name, 'color': habit.color.value, 'value': 10};
    }).toList();

    int dailyId = 1;

    Future<void> daily(num habitId) async {
      DateTime dateTime = _selectedValue;
      dailyGoal = await DailyGoalController()
          .getByDay2(dateTime.day, dateTime.month, habitId);
      dailyId = dailyGoal.id;
    }

    List<Color> habitColors = habits.map((habit) => habit.color).toList();
    if (dailiesLenght == 0) {
      habitColors = habits.map((habit) => Colors.grey).toList();
    }

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
            onPressed: () => UpdateUserModal().firstdialogBuilder(context),
            icon: const Icon(Icons.person,
                color: Color.fromRGBO(81, 185, 214, 1)),
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
              dateTextStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              dayTextStyle: const TextStyle(fontSize: 10),
              monthTextStyle: const TextStyle(fontSize: 10),
              onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                  _fetchHabits(); // Atualiza os hábitos e os daily goals para a nova data selecionada
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
                    // Stack(
                    //   children: [
                    //     Positioned.fill(
                    //       child: Center(
                    //         child: Text(
                    //           '2/2',
                    //           style: const TextStyle(
                    //             fontSize: 40,
                    //             color: Colors.pink,
                    //             letterSpacing: 0,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: const EdgeInsets.only(top: 10),
                    //       width: 152,
                    //       height: 130,
                    //       child: Chart(
                    //         data: data,
                    //         variables: {
                    //           'name': Variable(
                    //             accessor: (Map map) => map['name'] as String,
                    //           ),
                    //           'value': Variable(
                    //             accessor: (Map map) => map['value'] as num,
                    //           ),
                    //           'color': Variable(
                    //             accessor: (Map map) => map['color'] as int,
                    //           ),
                    //         },
                    //         transforms: [
                    //           Proportion(
                    //             variable: 'value',
                    //             as: 'percent',
                    //           )
                    //         ],
                    //         marks: [
                    //           IntervalMark(
                    //             position: Varset('percent') / Varset('name'),
                    //             color: ColorEncode(
                    //                 variable: 'color', values: habitColors),
                    //             modifiers: [StackModifier()],
                    //           ),
                    //         ],
                    //         coord: PolarCoord(
                    //           transposed: true,
                    //           dimCount: 1,
                    //           startRadius: 0.8,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: CarouselSlider(
              items: PeriodLabel.values.map((e) {
                int index = PeriodLabel.values.indexOf(e);
                Color color = Color(
                    int.parse("0xFF${itemColors[index % itemColors.length]}"));
                List<Habit> periodHabits =
                    habits.where((habit) => habit.habitCategory == e).toList();
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
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
                    const SizedBox(height: 10),
                    Expanded(
                        child: ListView.builder(
                      itemCount: periodHabits.length,
                      itemBuilder: (context, index) {
                        // Obter a meta diária específica para este hábito
                        DailyGoal habitDailyGoal = dailies.firstWhere((daily) =>
                            daily.habit?.id == periodHabits[index].id);
                        String goalVsCurrent = '';
                        if (habitDailyGoal.quantity != null) {
                          goalVsCurrent =
                              '${habitDailyGoal.quantity!.currentStatus} / ${habitDailyGoal.quantity!.goal}';
                        } else {
                          goalVsCurrent =
                              '${habitDailyGoal.booleanS!.currentStatus} / ${habitDailyGoal.booleanS!.goal}';
                        }

                        return Slidable(
                          startActionPane:
                              ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(
                              onPressed: ((context) {
                                daily(periodHabits[index].id);
                                showDailyGoalModal(context, dailyGoal.id,
                                    periodHabits[index].id);
                              }),
                              backgroundColor: Colors.pink,
                              icon: Icons.add,
                              padding: const EdgeInsets.all(0),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.elliptical(10.0, 10.0),
                                bottomLeft: Radius.elliptical(10.0, 10.0),
                              ),
                            ),
                            SlidableAction(
                              onPressed: ((context) {
                                DailyGoalController()
                                    .setDone(habitDailyGoal.id);
                                    alert.showConfirmationSnackBar(context, 'Hábito marcado como feito!');
                                setState(() {
                                    habitDailyGoal.quantity?.currentStatus += habitDailyGoal.quantity!.goal;
                                });
                              }),
                              backgroundColor:
                                  const Color.fromRGBO(81, 185, 214, 1),
                              foregroundColor: Colors.white,
                              icon: Icons.check,
                            ),
                          ]),
                          child: GestureDetector(
                            onTap: () => HabitsModal().firstdialogBuilder(
                                context, periodHabits[index].id),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: periodHabits[index].color,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        periodHabits[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        habitDailyGoal.quantity != null
                                            ? '${habitDailyGoal.quantity!.currentStatus}/${habitDailyGoal.quantity!.goal}'
                                            : '${habitDailyGoal.booleanS!.currentStatus}/${habitDailyGoal.booleanS!.goal}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        periodHabits[index].reference,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.5,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Create(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromRGBO(255, 71, 117, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class HabitList extends StatelessWidget {
  final List<Habit> habits;

  const HabitList({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: habits.map((habit) {
          return Text(
            habit.name,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          );
        }).toList(),
      ),
    );
  }
}
