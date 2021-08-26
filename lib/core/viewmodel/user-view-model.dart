import 'dart:io';

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
  String? emailErrorMessage;
  String? passwordErrorMessage;


  UserModel? get user => _user;
  ViewState get state=> _state;

  set state(ViewState value){
    _state = value;
    notifyListeners();        //state degisince aayuze bilgi verilir,tetikleme islemi
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
    }finally{
      state = ViewState.Idle;       //her islem sonunda idle olarak guncellenir
    }
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password) async {
    try{

      if(_emailPasswordCheck(email, password)){                                               //email ve password gecerliyse busy
          state = ViewState.Busy;
          _user = await _userRepository.createUserWithEmailAndPassword(email, password);
        return _user;
      }else {
        return null;
      }
    }finally{
      state = ViewState.Idle;       //her islem sonunda idle olarak guncellenir
    }
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async{
    try{

      if(_emailPasswordCheck(email, password)){
       // state = ViewState.Busy;  
        _user = await _userRepository.signInWithEmailAndPassword(email, password);
        return _user;
      }else return null;
    }finally{
      state = ViewState.Idle;       //her islem sonunda idle olarak guncellenir
    }
  }

  bool _emailPasswordCheck(String email, String password){
    var sonuc = true;

    if(password.length < 6){
      passwordErrorMessage = "En az 6 karakter olmalı";
      sonuc = false;
    }
    else passwordErrorMessage = null;                      //hata yoksa null degeri atanip temizlenmeli
    
    if(!email.contains("@")){
      emailErrorMessage = "Geçersiz email adresi";
      sonuc = false;
    }else emailErrorMessage = null;
    
    return sonuc;
  }

  Future<bool> updateUserName(String userID,String newUserName) async {

    var _sonuc = await _userRepository.updateUserName(userID,newUserName);
    if(_sonuc){
       _user!.userName = newUserName;
    }
    return _sonuc;
  }

  Future<String> uploadFile(String userID, String fileType, File? profilePhoto) async {
    var downloadLink = await _userRepository.uploadFile(userID,fileType,profilePhoto);
    return downloadLink;
  }

  Future<List<UserModel>> getAllUsers() async {
    var allUsersList = await _userRepository.getAllUsers();
    return allUsersList;
  }

  Future<void> createNames (String userID,String? firstName, String? lastName) async {
    await _userRepository.createNames(userID,firstName!, lastName);

  }


}