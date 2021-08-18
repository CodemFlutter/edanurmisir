import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/services/db_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDbService implements DBase{

  final FirebaseFirestore _firebaseAuth = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel? user) async {
    await _firebaseAuth.collection("users").doc(user!.userID).set(user.toMap());    //users isimli bir collection yan itablo olusturuldu,id'ye gore set ile kaydedildi
    
    DocumentSnapshot<Map<String,dynamic>> _okunanUser =
      await _firebaseAuth.doc("users/${user.userID}").get();//tablodan alinan bilgiler aktariliyor

    Map<String, dynamic>? _userInfoMap = _okunanUser.data();//map turunde degiskene ataniyor
    UserModel _userInfoObject = UserModel.fromMap(_userInfoMap!);//mapteki degiskenler obje haline getiriliyor
    print("Okunan user nesnesi: "+ _userInfoObject.toString());


    return true;
  }

}