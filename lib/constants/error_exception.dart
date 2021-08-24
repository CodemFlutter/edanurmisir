class ErrorAlert{
  static String? showMessage(String errorCode){

    switch(errorCode){
      case 'emaıl-already-ın-use':{
        return "Bu mail adresi zaten kullanımda, lütfen farklı bir mail kullanınız";
      }
      case 'wrong-password':{
        return "Yanlış şifre girdiniz, lütfen tekrar deneyiniz.";
      }
      case 'too-many-requests':{
        return "fazla request";
      }
       default: return "Bir hata olustu";
     
    }
  }
}