import 'package:shopping_list_app/core/model/user_model.dart';

abstract class AuthBase{

  Future<UserModel?> currentUser();
  Future<UserModel?> signInAnonymously();
  Future<bool> signOut();

}