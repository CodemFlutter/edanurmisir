import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/constants/app_buttons.dart';
import 'package:shopping_list_app/constants/constants.dart';
import 'package:shopping_list_app/constants/ps_alert_dialog.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';

class ProfilePage extends StatefulWidget {
  final UserModel? user;
  ProfilePage({ Key? key, required this.user }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? _userNameController;




  @override
  void initState(){
    super.initState();
    _userNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel? _userViewModel = Provider.of<UserViewModel>(context);
    _userNameController!.text= _userViewModel.user!.userName!;
    return Scaffold(
      body:SingleChildScrollView(
        child:Center(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius:75,
                  backgroundColor: background,
                  backgroundImage: NetworkImage(_userViewModel.user!.photoURL)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userViewModel.user!.email,
                  readOnly: true,
                  decoration:InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    border: OutlineInputBorder(  //textfield tiklanmamisken 
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: new BorderSide(
                          color: pDarkest,
                          )
                    )
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration:InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Kullanıcı Adı Giriniz",
                    labelText: "Kullanıcı Adı",
                    border: OutlineInputBorder(  //textfield tiklanmamisken 
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: new BorderSide(
                          color: pDarkest,
                          )
                    )
                  )

                ),
              ),
              AppButtons(
                buttonColor: pMain,
                buttonText: "Profil Güncelle",
                textColor: background,
                textSize: 15,
                onPressed:(){
                  _userNameGuncelle(context);
                } ,
                )
            ],
          )
          ) ,
        )
    );
  }
  void _userNameGuncelle (BuildContext context) async{
    UserViewModel? _userViewModel = Provider.of<UserViewModel>(context,listen:false);
    if(_userViewModel.user!.userName!= _userNameController!.text){
       var _updateResult = await _userViewModel.updateUserName(_userViewModel.user!.userID,_userNameController!.text);
       if(_updateResult == true){
         PsAlertDialog(title: "Güncelleme İşlemi", message: "Kullanıcı adınız güncellenmiştir.", mainButton: "Tamam").goster(context);

       }else{
         _userNameController!.text = _userViewModel.user!.userName!;      //eger kullanimdaysa eski username textfielda tekrar yazilmali
          PsAlertDialog(title: "Güncelleme İşlemi", message: "Kullanıcı adı zaten kullanımda, lütfen farklı bir kullanıcı adı deneyiniz.", mainButton: "Tamam").goster(context);
       }
    }
    else{
      PsAlertDialog(
        title:"UYARI",
        message:"Kullanıcı Adınızda Hiçbir Değişiklik Yapılmadı",
        mainButton: "Onayla",
      ).goster(context);
    }

  }
}