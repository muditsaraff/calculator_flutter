import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/util/sharedpref.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _loginFailed = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  final url = 'https://dummyjson.com/auth/login';

  void _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    SharePref pref = SharePref();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        pref.saveFirstName(data["firstName"]);
        pref.saveLastName(data["lastName"]);
        pref.saveid(data["id"]);
        pref.saveGender(data["gender"]);
        pref.saveEmail(data["email"]);

        
        // Login successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // Login failed
        setState(() {
          _loginFailed = true;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _loginFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Login Page'),
      //),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/whitebg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  'assets/images/bmwlogo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Color.fromARGB(255, 179, 175, 177),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Color.fromARGB(255, 179, 175, 177),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16.0),
              if (_loginFailed)
                Text(
                  'Invalid username or password',
                  style: TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                onPressed: _handleLogin,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
