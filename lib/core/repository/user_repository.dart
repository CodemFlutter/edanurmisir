//NETWORK(MODELLER) VE UI ARASINDAKİ KATMAN. KULLANILACAK SERVISE KARAR VERILIR
import 'package:shopping_list_app/core/locator.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/services/auth_base.dart';
import 'package:shopping_list_app/core/services/firebase_auth_service.dart';


class UserRepository implements AuthBase{
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();  //repo alinacak servis belirlendi

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


}