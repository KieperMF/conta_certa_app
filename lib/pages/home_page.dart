import 'package:conta_certa/pages/login_page.dart';
import 'package:conta_certa/services/autentication.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final autentication = AutenticationService(); 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Conta Certa'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Deslogar"),
              leading: Icon(Icons.logout),
              onTap: (){
                autentication.logout();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            )
          ],
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Text("Ola Mundo!"),
            Padding(padding: EdgeInsets.all(16)),
            TextField(
              decoration: InputDecoration(hintText: "informe algo"),
            )
          ],
        ),
      ),
    );
  }
}