import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 246, 247, 248);

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: YellowBird(),
        ),
      ),
    );
  }
}

class YellowBird extends StatefulWidget {
  const YellowBird({ Key? key }) : super(key: key);

  @override
  _YellowBirdState createState() => _YellowBirdState();
}

class _YellowBirdState extends State<YellowBird> {
  
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("My Super title"),
            content: Text("Hello World"),
          );
        }
      );
    });
  }
                 
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}