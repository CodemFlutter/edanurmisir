import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/services/auth_base.dart';


//FIREBASE'DEN ALINAN USERLARIN KENDI USERMODELIMIZ ILE ILISKILENDIRILMESI ISLEMI
class FirebaseAuthService implements AuthBase{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel?> currentUser() async {

    try{
      User? user = _firebaseAuth.currentUser!;
     return _userFromFirebase(user);
    }catch(e){
    }
     
  }

  UserModel? _userFromFirebase(User? user){
    if(user == null){return null; }                      //firebase'den gelen user null ise 
      else{                                           //usermodel'daki user'i da null'a esitle
    return UserModel(userID: user.uid,email: user.email);   //null degilse usermodel'daki user'a gelen degeri ata
      }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    }catch(e){
      print("ANONYMOUS SIGN IN ERROR:"+e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      await _firebaseAuth.signOut();
      return true;
      }
      catch(e){
        print("SIGN OUT ERROR:"+e.toString());
        return false;
      }
    }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password) async {
    
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);

  }



  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
  }

    
  }
