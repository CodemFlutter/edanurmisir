import 'package:shopping_list_app/core/model/user_model.dart';

abstract class AuthBase{

  Future<UserModel?> currentUser();
  Future<UserModel?> signInAnonymously();
  Future<bool> signOut();
  Future<UserModel?> signInWithEmailAndPassword(String email, String password);
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password);

}