import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/core/view/sign_in_view.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';
import 'home_view.dart';


/*UYGULAMA ILK ACILDIGINDA GORUNTULENECEK SAYFA*/

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);

    if(_userViewModel.state == ViewState.Idle)  { //modelviewdan gelen kullanici bostaysa
      if(_userViewModel.user == null){
        return SigninPage();
      }
      else{
        return HomePage(user: _userViewModel.user);
      }
    } else{
      return Scaffold(
        body: Center(
        child: CircularProgressIndicator()
        )
      );
    }

  }
}











