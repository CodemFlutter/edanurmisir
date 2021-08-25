import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _profilePhoto;



  @override
  void initState(){
    super.initState();
    _userNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
     var screenInfo = MediaQuery.of(context);
    final double h = screenInfo.size.height;
    UserViewModel? _userViewModel = Provider.of<UserViewModel>(context,listen:false);
    _userNameController!.text= _userViewModel.user!.userName!;
    return Scaffold(
      appBar: AppBar(title: Text("Profil Sayfası"),),
      body:SingleChildScrollView(
        child:Center(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap:(){
                    showModalBottomSheet(
                      context: context, 
                      builder:(context){
                        return Container(
                          height:h/5,
                          child: Column(
                            children: [
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title:Text("Kamera ile çek"),
                                  onTap: (){
                                    _takeFromCamera();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title:Text("Galeriden seç"),
                                  onTap: (){
                                    _selectFromGallery();
                                  },
                                ),

                            ],
                            ),
                        );
                      }
                      );
                  },
                  child: CircleAvatar(
                    radius:75,
                    backgroundColor: background,
                    backgroundImage: imageProvider(_userViewModel)
                    
                    ),
                ),
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
                  _updateProfilePhoto(context);
                  
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
         PsAlertDialog(title: "Güncelleme İşlemi", 
                      message: "Kullanıcı adınız güncellenmiştir.", 
                      mainButton: "Tamam").goster(context);

       }else{
         _userNameController!.text = _userViewModel.user!.userName!;      //eger kullanimdaysa eski username textfielda tekrar yazilmali
          PsAlertDialog(title: "Güncelleme İşlemi", 
          message: "Kullanıcı adı zaten kullanımda, lütfen farklı bir kullanıcı adı deneyiniz.", mainButton: "Tamam").goster(context);
       }
    }
  }

  void _updateProfilePhoto(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context,listen:false);
    if(_profilePhoto!=null){    //eger null degilse degisiklik yapilmistir
      String url = await _userViewModel.uploadFile(_userViewModel.user!.userID,"profil_foto",_profilePhoto);
      print("eklenen url: "+ url);
      if(url!=null){
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Profil güncellendi"),
              duration: Duration(milliseconds: 1200)),
        );
    }
    }

  }

  void _takeFromCamera() async{
    PickedFile? _newPhoto =  await ImagePicker.platform.pickImage(source: ImageSource.camera);
    
    Navigator.of(context).pop();
    setState(() {
      _profilePhoto = File(_newPhoto!.path);
    });
  }

  void _selectFromGallery() async{
    var _newPhoto = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      _profilePhoto = File(_newPhoto!.path);
    });
  }

  ImageProvider imageProvider(UserViewModel _userViewModel) {
    if (_profilePhoto == null) {
      return NetworkImage(_userViewModel.user!.photoURL);
    } else {
      return FileImage(_profilePhoto!);
    }
  }

}