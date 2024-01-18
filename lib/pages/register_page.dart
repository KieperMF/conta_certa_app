import 'package:conta_certa/pages/login_page.dart';
import 'package:conta_certa/services/autentication.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _autentication = AutenticationService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Login')),
        ],
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(hintText: 'Informe seu nome'),
                        validator: (String? value) {
                          if (value == null) {
                            return 'Preencha seu nome';
                          }
                          if (value.length < 2) {
                            return 'O nome é muito curto';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(hintText: 'Email'),
                        validator: (String? value) {
                          if (value == null) {
                            return 'O E-mail não pode ser vazio';
                          }
                          if (!value.contains('@')) {
                            return 'E-mail Inválido';
                          }
                          if (value.length < 5) {
                            return 'O E-mail é muito curto';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        validator: (String? value) {
                          if (value == null) {
                            return 'A senha não pode ser vazia';
                          }
                          if (value.length < 5) {
                            return 'A senha é muito curta';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(16)),
                    ElevatedButton(
                        onPressed: () {
                          registerMethod();
                        },
                        child: const Text('Cadastrar')),
                  ],
                ),
              ))),
    );
  }

  registerMethod() {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (_formKey.currentState!.validate()) {
      print('valido');
      _autentication.registerUser(
          userName: name, userEmail: email, userPassword: password);
      print('${emailController.text} ${passwordController.text}');
    } else {
      print('invalido');
    }
  }
}
