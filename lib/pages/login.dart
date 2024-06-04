import 'package:aurora/main.dart';
import 'package:aurora/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/pages/testing.dart';
import 'package:http/http.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const MaterialApp(
      title: 'Login',
=======
    return MaterialApp(
      title: 'User Post Example',
>>>>>>> ac763772eac9dc4b716c1e029ba1a34cf3bfd7de
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Login page'),
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0)   
=======
        title: const Text('User Post Example'),
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/AURORA.png'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Color.fromARGB(255, 74, 73, 73),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 350,
              height: 240,
              decoration: BoxDecoration(
                color: const Color.fromARGB(252, 252, 252, 252),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 228, 228, 228),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email *',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 74, 73, 73))),
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(252, 252, 252, 252),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 228, 228, 228),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Maria da Silva',
                        hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 167, 166, 166)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Senha *',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 74, 73, 73))),
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(252, 252, 252, 252),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 228, 228, 228),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      obscureText: hide,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: '***',
                        hintStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 167, 166, 166)),
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
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Response response = await UserController().authenticateUser(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                backgroundColor: const Color.fromRGBO(81, 185, 214, 1),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ainda não possui conta?',
              style: TextStyle(fontSize: 12),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                  child: const Text('Clique aqui',
                      style: TextStyle(color: Color.fromARGB(255, 74, 73, 73))),
                ),
              ],
            )),
          ],
        ),
      ),
>>>>>>> ac763772eac9dc4b716c1e029ba1a34cf3bfd7de
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
