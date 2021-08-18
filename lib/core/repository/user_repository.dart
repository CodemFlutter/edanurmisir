//NETWORK(MODELLER) VE UI ARASINDAKİ KATMAN. KULLANILACAK SERVISE KARAR VERILIR
import 'package:shopping_list_app/core/locator.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/services/auth_base.dart';
import 'package:shopping_list_app/core/services/firebase_auth_service.dart';
import 'package:shopping_list_app/core/services/firestore_db_service.dart';


class UserRepository implements AuthBase{
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();  //repo alinacak servis belirlendi
  FirestoreDbService _firestoreDbService = locator<FirestoreDbService>();

  @override
  Future<UserModel?> currentUser() async {
    return await _firebaseAuthService.currentUser();
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    return await _firebaseAuthService.signInAnonymously();
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password) async {

    UserModel? _user =await _firebaseAuthService.createUserWithEmailAndPassword(email, password);
    bool _sonuc = await _firestoreDbService.saveUser(_user);
    if(_sonuc){                       //kullanici kaydolduysa kullanici objesini dondur
      return _user;
    }else return null;
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async{       //firebase auth service'ten gelen metotlar
    return await _firebaseAuthService.signInWithEmailAndPassword(email, password);
  }




}