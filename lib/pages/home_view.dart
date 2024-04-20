import 'package:aurora/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/pages/habit_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 250, 250, 250)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                     

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(81, 185, 214, 1.0),
                    ),
                    child: const Text('Post User'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Já possui uma conta?',
              style: TextStyle(fontSize: 12),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              
              child: const Text('Clique aqui'),
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
