import 'package:conta_certa/model/user_model.dart';
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
  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
    Future.delayed( const Duration(milliseconds: 1000), () {
      load();
    });
  }
  Future<void> load()async{
    await userModel.getUser();
  }
  

  @override
  Widget build(BuildContext context) {   

    return  Scaffold(
      appBar: AppBar(
        title:const Text('Conta Certa'),
      ),
      body:  Center(
        child: Column(
          children: [
            const Text("Home Page"),
            const Padding(padding: EdgeInsets.all(16)),
            const TextField(
              decoration: InputDecoration(hintText: "informe algo"),
            ),
            ElevatedButton(onPressed: (){
              autentication.logout();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }, child:const Text("logout"))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListenableBuilder(
          listenable: userModel, 
          builder: (context,_){
            if(userModel.user != null){
              return ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('${userModel.user!.displayName}'), 
              accountEmail: Text('${userModel.user!.email}')),
            ListTile(
              title:const Text("Deslogar"),
              leading:const Icon(Icons.logout),
              onTap: (){
                autentication.logout();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            )
          ],
        );
            }else{
              return const Text("erro");
            }
          }),
      ),
    );
  }

}