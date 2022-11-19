import 'package:flutter/material.dart';

import '../api/api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var phone = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isLoading = false;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.amberAccent,
        child: Center(
            child: SizedBox(
          height: height / 12 * 4,
          width: width / 12 * 6,
          child: Column(
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Phone',
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: isLoading == true
                      ? () {}
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          Map<String, String> payload = {
                            'phone': phone.text,
                            'password': password.text
                          };
                          bool loginSuccess = await login(payload);

                          setState(() {
                            isLoading = false;
                          });

                          if (loginSuccess) {
                            setState(() {
                              Navigator.pushNamed(context, "/");
                            });
                          }
                        },
                  child: isLoading == true
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Login"))
            ],
          ),
        )),
      ),
    );
  }
}
