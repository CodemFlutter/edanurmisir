import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/core/view/admin_home_view.dart';
import 'package:shopping_list_app/core/view/home_view.dart';
import 'package:shopping_list_app/core/view/sign_in_view.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';


class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    if(_userViewModel.state == ViewState.Idle)  { //modelviewdan gelen kullanici bostaysa
      if(_userViewModel.user == null){
        return SigninPage();
      }
      else{
            return _userViewModel.user!.role=="admin" ? 
            AdminHomePage(user: _userViewModel.user):
            HomePage(user:_userViewModel.user);
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