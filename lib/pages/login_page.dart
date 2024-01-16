import 'package:conta_certa/model/user_model.dart';
import 'package:conta_certa/pages/home_page.dart';
import 'package:conta_certa/pages/register_page.dart';
import 'package:conta_certa/services/autentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final autentication = AutenticationService();
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta Certa', style: TextStyle(color: Colors.white),),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              style:const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Text('Cadastro', style: TextStyle(color: Colors.white),)),
        ],
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.blue[700],
      body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    "images/logo.jpg",
                    width: 200,
                    height: 200,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(16)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'Informe seu Email',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Preencha seu Email';
                      }
                      if (!value.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: 'Informe sua Senha',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Preencha sua Senha';
                      }
                      if (value.length < 5) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.all(16)),
                    ElevatedButton(
                      onPressed: () {
                        Login();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            )
          )),
    );
  }

  Login() {
    String email = emailController.text;
    String password = passwordController.text;
    autentication.loginUser(email: email, password: password);

    if (_formKey.currentState!.validate()) {
      
    Future.delayed( const Duration(milliseconds: 1000), ()async {
      if (FirebaseAuth.instance.currentUser != null) {
        print("credenciado");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais Inválidas')));
      }
    });
      
    } else {
      print('denied');
    }
  }
}
