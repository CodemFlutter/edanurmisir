import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/services/db_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDbService implements DBase{

  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel? user) async {
    await _firebaseDB.collection("users").doc(user!.userID).set(user.toMap());    //users isimli bir collection yan itablo olusturuldu,id'ye gore set ile kaydedildi
    
    DocumentSnapshot<Map<String,dynamic>> _okunanUser =
      await _firebaseDB.doc("users/${user.userID}").get();//tablodan alinan bilgiler aktariliyor

    Map<String, dynamic>? _userInfoMap = _okunanUser.data();//map turunde degiskene ataniyor
    UserModel _userInfoObject = UserModel.fromMap(_userInfoMap!);//mapteki degiskenler obje haline getiriliyor
    print("Okunan user nesnesi: "+ _userInfoObject.toString());


    return true;
  }

  @override
  Future<UserModel?> readUser(String userID) async{
    DocumentSnapshot<Map<String,dynamic>> _okunanUser =
     await _firebaseDB.collection("users").doc(userID).get();
    Map<String,dynamic>? _userInfoMap = _okunanUser.data();
    UserModel _userInfoObject = UserModel.fromMap(_userInfoMap!);
    print("Okunan user nesnesi: "+ _userInfoObject.toString());
    return _userInfoObject;

  }

  @override
  Future<bool> updateUserName(String userID, String newUserName) async{
    var users = await _firebaseDB.collection("users").where("userName", isEqualTo: newUserName).get();
    if(users.docs.length>=1){               //eger boyle bir kullanici varsa false
      return false;
    }else{
      await _firebaseDB.collection("users").doc(userID).update({"userName":newUserName});//yoksa guncel degeri girilen deger
      return true;
    }
  }
  
  
  Future<bool> updateProfilePhoto(String userID, String profilePhotoURL) async {
      await _firebaseDB.collection("users")
      .doc(userID)
      .update({"photoURL":profilePhotoURL});//yoksa guncel degeri girilen deger
      return true;
  }
}