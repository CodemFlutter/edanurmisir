import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/core/locator.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/repository/user_repository.dart';
import 'package:shopping_list_app/core/services/auth_base.dart';


enum ViewState{Idle, Busy}              //arayuz mesgul mu kontrolu icin

class UserViewModel with ChangeNotifier implements AuthBase{   //mixin
  ViewState _state = ViewState.Idle;      //baslangicta user bosta 
  UserRepository _userRepository = locator<UserRepository>();
  UserModel? _user;

  UserModel? get user => _user;
  ViewState get state=> _state;

  set state(ViewState value){
    _state = value;
    notifyListeners();        //state degisince aayuze bilgi verilir
  }

  UserViewModel(){
    currentUser();        //burada bir user nesnesi olusturuldugunda currentusermetodu cagrilacak
  }

  @override
  Future<UserModel?> currentUser() async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return _user;
    }catch(e){
      debugPrint("Kullanici alinamadi"+ e.toString());
      return null;
    }finally{
      state = ViewState.Idle;       //her islem sonunda idle olarak guncellenir
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    }catch(e){
      debugPrint("Kullanici girisi yapilamadi"+ e.toString());
      return null;
    }finally{
      state = ViewState.Idle;       //her islem sonunda idle olarak guncellenir
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;                                       //cikis yapince user null olmali
      return sonuc;
    }catch(e){
      debugPrint("Kullanici alinamadi"+ e.toString());
      return false;
    }finally{
      state = ViewState.Idle;       //her islem sonunda idle olarak guncellenir
    }
  }

}