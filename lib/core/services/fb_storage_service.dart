import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopping_list_app/core/services/storage_base.dart';

class FirebaseStorageService implements StorageBase{
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference? _storageReference;
  @override
  Future<String> uploadFile(String userID, String fileType, File? fileToUpload) async {
    _storageReference = _firebaseStorage.ref().child(userID).child(fileType).child("profil_foto.png");    //id ve dpsya turu referans olarak alinacak
    UploadTask _uploadTask = _storageReference!.putFile(fileToUpload!);
    String? _url;
    await _uploadTask.then((res) async {
      _url = await res.ref.getDownloadURL();
      return _url;
    });
    return _url!;

    
    
    /*uploadTask.then((res){
      url=  uploadTask._storageReference!.getDownloadURL().toString();      //upload islemi tamamlandiginda url tanimlanir 
    });
    return url;*/
    

}
}