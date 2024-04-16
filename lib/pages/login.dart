import 'package:aurora/main.dart';
import 'package:aurora/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/pages/habit_view.dart';
import 'package:http/http.dart';

class Login extends StatelessWidget {
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Post Example'),
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/AURORA.png'),
            ),
            SizedBox(height: 40),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 250, 250, 250)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: hide,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: Icon(hide
                              // ignore: dead_code
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Response response =
                          await UserController().authenticateUser(
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp2(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(81, 185, 214, 1.0),
                    ),
                    child: Text('Entrar'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ainda não possui conta?',
              style: TextStyle(fontSize: 12),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              child: Text('Clique aqui'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
