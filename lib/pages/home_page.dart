import 'package:conta_certa/pages/login_page.dart';
import 'package:conta_certa/services/autentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final autentication = AutenticationService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {   
    
    final User? user = auth.currentUser;
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Conta Certa'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('${user?.displayName}'), 
              accountEmail: Text('${user?.email}')),
            ListTile(
              title:const Text("Deslogar"),
              leading:const Icon(Icons.logout),
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