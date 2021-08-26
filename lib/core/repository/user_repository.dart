//NETWORK(MODELLER) VE UI ARASINDAKİ KATMAN. KULLANILACAK SERVISE KARAR VERILIR
import 'dart:io';
import 'package:shopping_list_app/core/locator.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/services/auth_base.dart';
import 'package:shopping_list_app/core/services/fb_storage_service.dart';
import 'package:shopping_list_app/core/services/firebase_auth_service.dart';
import 'package:shopping_list_app/core/services/firestore_db_service.dart';


class UserRepository implements AuthBase{
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();  //repo alinacak servis belirlendi
  FirestoreDbService _firestoreDbService = locator<FirestoreDbService>();
  FirebaseStorageService _fbStorageService = locator<FirebaseStorageService>();

  @override
  Future<UserModel?> currentUser() async {
    UserModel? _user= await _firebaseAuthService.currentUser();    //authservide'ten mevcut kullanici alinir
    return await _firestoreDbService.readUser(_user!.userID);     //mevcut kullanici bilgileri authservide yerine db'den okunur
   

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
      return await _firestoreDbService.readUser(_user!.userID);
    }else return null;
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async{       //firebase auth service'ten gelen metotlar
    UserModel? _user =  await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    return await _firestoreDbService.readUser(_user!.userID);
    
  }

  Future<bool> updateUserName(String userID, String newUserName) async{
    return await _firestoreDbService.updateUserName(userID, newUserName);
  }

  Future<String> uploadFile(String userID, String fileType, File? profilePhoto) async {
    var profilePhotoURL =  await _fbStorageService.uploadFile(userID, fileType, profilePhoto );
    await _firestoreDbService.updateProfilePhoto(userID,profilePhotoURL);
    return profilePhotoURL;
  }

  Future<List<UserModel>> getAllUsers() async{
    var allUsersList = await _firestoreDbService.getAllUsers();
    return allUsersList;

  }

  Future<String?> createNames(String userID, String? firstName, String? lastName) async {
    await _firestoreDbService.createNames(userID, firstName, lastName);
    return firstName;
  }
}