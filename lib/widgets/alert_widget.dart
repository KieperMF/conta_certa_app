import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget{
  final String alertMessage;
  const AlertWidget({
    Key? key,
    required this.alertMessage,
  }): super(key: key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      content: Text(alertMessage),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child:const Text("Fechar"))
      ],
    );
  }
}