import 'package:flutter/material.dart';
import 'package:shopping_list_app/constants/constants.dart';

import 'app_buttons.dart';

class TextFieldDialog extends StatelessWidget {
  const TextFieldDialog({
    Key? key,
    required this.h,
    required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.purple.shade50,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      
       ),
      child: Container(
        
        height:h/3,
        width:w-40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.group_add,size: h/20,color: pDarkest,),
                     Text('   Grup Ekle',
                     style:TextStyle( 
                       color:pDarkest,
                       fontSize: 20,
                       fontWeight: FontWeight.bold
                       )),
                   ],
                 ),
                   Padding(
                     padding: EdgeInsets.only(bottom:h/20),
                     child: SizedBox(
                            
                       height:h/15,
                       width:w/1.5,
                       child: TextField( 
                       decoration: InputDecoration( 
                       labelText: "Grup Adı",
                  filled: true, 
                       fillColor: Colors.white,
                       border: OutlineInputBorder( 
                        borderRadius: BorderRadius.all(Radius.circular(40.0)))
                 )
               ),
                     ),
                   ),
               Row(
                 
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                 Padding(
                   padding: EdgeInsets.only(right:10),
                   child: SizedBox(
                     height:h/23,
                     width: w/4,
                     child: AppButtons(
                       
                       textSize:0.5,
                       buttonColor: pLight,
                       textColor: pDarkest,
                       buttonText: "İptal",
                       onPressed:(){
                      Navigator.pop(context);
                       }, 
                      ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:10),
                   child: SizedBox(
                     height: h/23,
                     width:w/3.4,
                     child: AppButtons(
                       textSize:0.5,
                       buttonColor: pDarkest,
                       textColor: pLight,
                       buttonText: "Tamam",
                       
                       onPressed:(){
                      // Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
                                                           
                       }, 
                      ),
                   ),
                 ),
              
               ],)
               ],
                      ),
      ),
       
    );
  }
}
