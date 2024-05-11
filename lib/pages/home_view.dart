import 'package:aurora/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/pages/habit_view.dart';
import 'package:flutter/widgets.dart';

class MyApp extends StatelessWidget {
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool hide1 = true;
  bool hide2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Post Example'),
      ),
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/AURORA.png'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Cadastro',
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
              height: 450,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nome *', style: TextStyle(fontFamily: 'Montserrat',
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Maria da Silva',
                        hintStyle: TextStyle(fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 167, 166, 166)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Email *', style: TextStyle(fontFamily: 'Montserrat', 
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
                        hintText: 'maria@gmail.com',
                        hintStyle: TextStyle(fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 167, 166, 166)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Senha *', style: TextStyle(fontFamily: 'Montserrat',
                   color: Color.fromARGB(255, 74, 73, 73))),
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(252, 252, 252, 252),
                      borderRadius: BorderRadius.circular(
                          8.0), // Ajuste conforme necessário
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
                      obscureText: hide1,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: '***',
                        hintStyle: const TextStyle(fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 167, 166, 166)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hide1 = !hide1;
                              });
                            },
                            icon: Icon(hide1
                                // ignore: dead_code
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Confirme sua senha *', style: TextStyle(fontFamily: 'Montserrat',
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
                      obscureText: hide2,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: '***',
                        hintStyle: const TextStyle(fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 167, 166, 166)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hide2 = !hide2;
                              });
                            },
                            icon: Icon(hide2
                                // ignore: dead_code
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(6),
                            ),
                              backgroundColor:
                                  const Color.fromRGBO(255, 71, 117, 1)),
                          child: const Text('Cancelar',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(    
                          onPressed: () {
                            //passwords gotta be equal
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              UserController().postUser(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );

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
                              borderRadius:
                                  BorderRadius.circular(6),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(81, 185, 214, 1),
                          ),
                          child: const Text('Cadastrar',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Já possui uma conta?',
              style: TextStyle(fontSize: 12),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: const Text('Clique aqui', style: TextStyle(color: Color.fromARGB(255, 74, 73, 73))),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}