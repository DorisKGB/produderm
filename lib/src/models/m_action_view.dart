import 'package:flutter/material.dart';

enum TypeActionView{error, success}

class MActionView {
  late String? message;
  late TypeActionView type;
  
  MActionView.messageSuccess(this.message): type= TypeActionView.success;
  MActionView.messageError(this.message): type= TypeActionView.success;

  void execute ({required BuildContext? context}){
    switch(type){      
      case TypeActionView.error:
        showMessage(context!,false);
        break;
      case TypeActionView.success:
        showMessage(context!,false);
        break;
    }
  }

  void showMessage(BuildContext context,[bool success=true]){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
  }
}