import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/constants/platform_sensitive_widget.dart';

class PsAlertDialog extends PlatformSensitiveWidget{

  final String title;
  final String? message;
  final String mainButton;
  late String? closeButton;          //kullanilsa da olur kullanilmasa da 
  late TextField? textField;


  PsAlertDialog({required this.title,required this.message,required this.mainButton,this.closeButton,this.textField});

  Future<bool?> goster(BuildContext context) {
    return Platform.isIOS ?  showCupertinoDialog<bool?>(context: context, builder: (context)=>this):
       showDialog<bool?>(context: context, builder: (context)=>this, barrierDismissible: false);
  }



  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message!),
      actions: _checkDialogButtons(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
     return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message!),
      actions: _checkDialogButtons(context),
    );
  }

  List<Widget> _checkDialogButtons(BuildContext context){
      final allButtons = <Widget>[];
        if(Platform.isIOS){
          if(closeButton!=null){
            allButtons.add(
            CupertinoDialogAction(
              child: Text("Tamam"),
              onPressed:() {Navigator.of(context).pop(true);},
            )
            );
          }
          allButtons.add(
            CupertinoDialogAction(
              child: Text("İptal"),
              onPressed:() {Navigator.of(context).pop(false);},
              )
          );
        }else{
          if(closeButton!=null){
            allButtons.add(
            CupertinoDialogAction(
              child: Text("Tamam"),
              onPressed:() {Navigator.of(context).pop(true);},
            )
            );
          }
          allButtons.add(
            TextButton(
              child: Text("İptal"),
              onPressed:() {Navigator.of(context).pop(false);},
              )
          );
        }
      return allButtons;
  }

}