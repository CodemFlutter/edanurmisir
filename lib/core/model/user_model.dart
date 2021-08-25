import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String userID;
  String? email;
  String? userName;
  String? password;
  late String photoURL;
  String? role;
  String? firstName;
  String? lastName;
  String? gender;
  String? birthDate;
  String? phoneNumber;
  bool isDeleted=false;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  

  UserModel({required this.userID, required this.email});

  Map<String,dynamic> toMap(){
    return {
      'userID':userID,
      'email': email,
      'userName' : userName??email!.substring(0,email!.indexOf("@"))+randomSayiUret(),
      'password':password,
      'photoURL':"https://firebasestorage.googleapis.com/v0/b/shopping-list-edb.appspot.com/o/ppicture.png?alt=media&token=a66bb78b-d287-4841-9a4c-4f62c2670bc3",
      'role':email=="eda@eda.com"?"admin":"kullanici", //userid bu ise true yap
      'firstName':firstName,
      'lastName':lastName,
      'gender':gender,
      'birthDate':birthDate,
      'phoneNumber':phoneNumber??"",
      'isDeleted':isDeleted,
      'deletedAt':deletedAt,
      'createdAt':createdAt??FieldValue.serverTimestamp(),
      'updatedAt':updatedAt??""
    };
  }

  UserModel.fromMap(Map<String,dynamic> map):
  userID= map["userID"],
  email= map["email"],
  userName= map["userName"],
  password= map["password"],
  photoURL= map["photoURL"],
  role= map["role"],
  firstName= map["firstName"],
  lastName= map["lastName"],
  gender= map["gender"],
  birthDate=map["birthDate"],
  phoneNumber = map["phoneNumber"],
  isDeleted= map["isDeleted"];
  //deletedAt= (map["deletedAt"] as Timestamp).toDate(),
  //createdAt= (map["createdAt"] as Timestamp).toDate(),
  //updatedAt= (map["updatedAt"] as Timestamp).toDate();

  @override
  String toString(){
    return "User{userName:$userName, email: $email, role:$role}";
  }

  String randomSayiUret(){
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }

}