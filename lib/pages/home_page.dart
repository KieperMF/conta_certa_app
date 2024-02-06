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
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      load();
    });
  }

  Future<void> load() async {
    await autentication.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListenableBuilder(
            listenable: autentication,
            builder: (context, _) {
              if (autentication.user != null) {
                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                        accountName: Text('${autentication.user!.displayName}', style:const TextStyle(fontSize: 16)),
                        accountEmail: Text('${autentication.user!.email}', style:const TextStyle(fontSize: 16))),
                    ListTile(
                      title: const Text("Deslogar"),
                      leading: const Icon(Icons.logout),
                      onTap: () {
                        autentication.logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    )
                  ],
                );
              } else {
                return ListView(
                  children: [
                    const UserAccountsDrawerHeader(
                        accountName: Text('Não foi possível carregar', style: TextStyle(fontSize: 20)),
                        accountEmail: Text('as informações', style: TextStyle(fontSize: 20),)),
                    ListTile(
                      title: const Text("Deslogar"),
                      leading: const Icon(Icons.logout),
                      onTap: () {
                        autentication.logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    )
                  ],
                );
              }
            }),
      ),
      body: Center(
          child: ListenableBuilder(
              listenable: autentication,
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.all(16)),
                    if (autentication.user != null) ...[
                      Text(
                        "Bem vindo, ${autentication.user!.displayName}",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ],
                );
              })),
    );
  }
}
