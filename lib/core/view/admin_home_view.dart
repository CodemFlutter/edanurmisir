import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';


// OTURUM ACMIS KULLANICILARIN GORECEGI SAYFA
class AdminHomePage extends StatefulWidget {
  final UserModel? user;
  AdminHomePage({ Key? key , required this.user}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ADMİN SAYFASI ${widget.user!.userID},${widget.user!.role}", style:TextStyle(fontSize: 20)), //kullanici bilgisi sayfaya aktarilir
            ElevatedButton(
              onPressed: (){
                _cikisYap(context);
              }, 
              child: Text("Çıkış"))
          ],
          ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen:false);
    bool sonuc = await _userViewModel.signOut();
    return sonuc;
  }
}