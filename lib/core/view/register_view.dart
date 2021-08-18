
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/constants/app_buttons.dart';
import 'package:shopping_list_app/constants/constants.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';



class RegisterPage extends StatefulWidget {


  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
  var screenInfo = MediaQuery.of(context);
  final double h = screenInfo.size.height;
  final double w = screenInfo.size.width;
  String? _email;
  String? _password;
  final _userViewModel = Provider.of<UserViewModel>(context,listen:false);
  

  _formSubmit() async {
    _formKey.currentState!.save();
    debugPrint("email:"+_email!+"Şifre:"+ _password!);
    UserModel? kaydolanUser = await _userViewModel.createUserWithEmailAndPassword(_email!, _password!); //viewmodel user model'a cevrildi
    if(kaydolanUser!=null){
      print("Kaydolan User Email: "+_email!+"Şifre:"+_password!);
    }else{

    }
  }


  return Scaffold(
    body:SingleChildScrollView(
      child:Container(
        height: h,
        width: w,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
                Padding(
                  padding: EdgeInsets.only(top:h/8),
                  child: Text("Üyelik Formu",style:TextStyle(fontSize: 36)),
                ),
                Padding(
                  padding: EdgeInsets.only(top:h/10.0, bottom:h/30,left:w/10,right:w/10),
                  child: TextFormField(
                      onSaved: (String? eval){
                        _email = eval;
                      },
                      
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration( 
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Email",
                      errorText: _userViewModel.emailErrorMessage != null ? _userViewModel.emailErrorMessage: null, //hata mesajı varsa goster, yoksa null'la sifirla
                      filled: true, 
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(//textfield tiklaninca
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(width: 1.5,color: pDarkest),
                     ),
                      border: OutlineInputBorder(  //textfield tiklanmamisken 
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: new BorderSide(
                        color: pDarkest,
                        )
                      )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom:h/10.0, top:h/40,left:w/10,right:w/10),
                  child: TextFormField( 
                    obscureText: true, 
                    onSaved: (String? pval){
                        _password = pval;
                      },
                    decoration: InputDecoration( 
                      prefixIcon: Icon(Icons.password),
                      hintText: "Şifre",
                      errorText: _userViewModel.passwordErrorMessage != null ? _userViewModel.passwordErrorMessage: null, 
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
                ),
                AppButtons(       //Oturum ac butonu
                    buttonText: "KAYDOL",
                    buttonColor: pDarkest,
                    textSize: 20,
                    textColor: pLight,
                    onPressed: ()=> _formSubmit(),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top:30.0),
                   child: GestureDetector(  
                    onTap:(){      
                      Navigator.pop(context);
                    },
                    child: Text("Giriş Sayfasına Dön",  
                    style:TextStyle(
                      color: pDarkest,
                      fontSize:20,
                      decoration: TextDecoration.underline
                      )
                    ),
                    ),
                 ),
            ],
          ),
        ),
      ) ,
    )
  );
  }
}

