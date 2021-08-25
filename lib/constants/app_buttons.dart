import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  
   final String buttonText;
   final Color buttonColor;
   final double textSize;
   final Color textColor;
   final VoidCallback onPressed;
  

   const AppButtons(
     {required this.buttonText,
      required this.buttonColor,
      required this.textSize,
      required this.textColor,
      required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    
            onPressed:onPressed,
            style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: StadiumBorder() 
            ),
            child: Text(buttonText,style:TextStyle(fontSize:20)),
    );
  }
}