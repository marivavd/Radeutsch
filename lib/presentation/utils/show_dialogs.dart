import 'package:flutter/material.dart';

void showError(BuildContext context, String error)async{
  showDialog(context: context, builder: (_) => AlertDialog(
    title: Text("Error"),
    content: Text(error),
    actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Text('Ok'))
    ],
  ));
}

void hideLoading(BuildContext context){
  Navigator.of(context).pop();
}

void showLoading(BuildContext context)async{
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ));
}