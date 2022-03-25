import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Counter>(
            create: (context) => Counter(),
          ),
          ChangeNotifierProvider<MyLogin>(
            create: (context) => MyLogin(),
          ),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var resultText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App with Provider'),
      ),
      body: Column(
        children: [
          Consumer<Counter>(
            builder: (context, counter, child) {
              return Text(counter.counter.toString(),
                  style: Theme.of(context).textTheme.headline4);
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                var myLogin = context.read<MyLogin>();
                myLogin.setLoginData(
                    emailController.text, passwordController.text);
              },
            ),
          ),
          const SizedBox(height: 20),
          Consumer<MyLogin>(
            builder: (ctx, myLogin, child) {
              return Text(myLogin._email + ' ' + myLogin._password);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var counter = context.read<Counter>();
          counter.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Counter extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class MyLogin extends ChangeNotifier {
  String _email = '';
  String _password = '';

  void setLoginData(String email, String pass) {
    _email = email;
    _password = pass;
    notifyListeners();
  }
}
