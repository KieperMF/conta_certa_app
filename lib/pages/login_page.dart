import 'package:conta_certa/pages/home_page.dart';
import 'package:conta_certa/services/autentication.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration:const InputDecoration(hintText: 'Informe seu Email'),
                validator: (String? value) {
                  if(value!.isEmpty){
                    return 'Preencha seu Email';
                  }
                  if(!value.contains('@')){
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration:const InputDecoration(hintText: 'Informe sua Senha'),
                validator: (String? value) {
                  if(value!.isEmpty){
                    return 'Preencha sua Senha';
                  }
                  if(value.length < 5){
                    return 'Senha muito curta';
                  }
                  return null;
                },
              ),
              ElevatedButton(onPressed: (){
                Login();
              }, child:const Text("Login"))
            ],
          ),
        )),
    );
  }

  Login(){
    String email = emailController.text;
    String password = passwordController.text;

    if(_formKey.currentState!.validate()){
      print("credenciado");
      autentication.loginUser(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }else{
      print('denied');
    }
  }
}