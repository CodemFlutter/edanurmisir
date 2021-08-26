import 'package:shopping_list_app/core/model/user_model.dart';

abstract class DBase {
  Future<bool> saveUser(UserModel user);    //kullanicinin kaydolma durumunu kontrol eder
 Future<UserModel?> readUser(String userID);  
 Future<bool> updateUserName(String userID,String newUserName);
 Future<bool> updateProfilePhoto(String userID,String profilePhotoURL);
 Future<bool> createNames(String userID, String? firstName, String? lastName);
 Future<List<UserModel>> getAllUsers();


}