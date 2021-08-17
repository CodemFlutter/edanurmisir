
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/constants/app_buttons.dart';
import 'package:shopping_list_app/constants/constants.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';


class SigninPage extends StatefulWidget {
  

  void _misafirGirisi(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen:false);
    UserModel? _user = await _userViewModel.signInAnonymously();
    print("Giris yapan kullanici id:${_user?.userID.toString()}");
    }

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  

  @override
 Widget build(BuildContext context) {
  var screenInfo = MediaQuery.of(context);
  final double h = screenInfo.size.height;
  final double w = screenInfo.size.width;

    return Scaffold(
      
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: h,
            width:w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  lightText,
                  background,
                ]
                )
            ),
            child: Column( 
              children:[
                Padding(
                  padding: EdgeInsets.only(top:h/6),
                  child: Text("Giriş Yap",style:TextStyle(fontSize: 35)),
                ),
                  
                EmailTextField(h: h, w: w),            
                PasswordTextField(h: h, w: w),
                AppButtons(
                  buttonText: "OTURUM AÇ",
                  buttonColor: pDarkest,
                  textSize: 20,
                  textColor: pLight,
                  onPressed: onPressed
                ),

                GestureDetector(  
                  onTap:(){      
       
                  },
                  child: Text("Üye ol",  
                  style:TextStyle(
                    color: pDarkest,
                    fontSize:30,
                    decoration: TextDecoration.underline
                    )
                  ),
                  ),

                  GestureDetector(  //Misafir girisi
                  onTap:(){      
                     widget._misafirGirisi(context);
                  },
                  child: Text("Misafir girişi",  
                  style:TextStyle(
                    color: pDarkest,
                    fontSize:30,
                    decoration: TextDecoration.underline
                    )
                  ),
                  )
              ] 
            ),
          ),
        ),
      )
    );
  }

 
    
  
  void onPressed(){

  }
  
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.h,
    required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(bottom:h/10.0, top:h/40,left:w/10,right:w/10),
    child: TextField( 
    onChanged: (val){
                  
    },
      obscureText: true, 
      decoration: InputDecoration( 
      hintText: "Şifre",
      filled: true,  
      fillColor: Colors.white,  
      focusedBorder: OutlineInputBorder(//textfield tiklaninca
      borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 1.5,color: pDarkest),),
          border: OutlineInputBorder(  //textfield tiklanmamisken 
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: new BorderSide(
          color: pDarkest,
            )
            )
         )
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.h,
    required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Padding(    
      padding: EdgeInsets.only(top:h/10.0, bottom:h/20,left:w/10,right:w/10),
      child: TextField( 
      onChanged: (val){  
    },
    decoration: InputDecoration( 
    hintText: "Email",
    filled: true, 
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(//textfield tiklaninca
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(width: 1.5,color: pDarkest),),
    border: OutlineInputBorder(  //textfield tiklanmamisken 
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: new BorderSide(
    color: pDarkest,
    )
            )
         )
        ),
    );
    
  }
  

  
}

