import 'package:get_it/get_it.dart';
import 'package:shopping_list_app/core/repository/user_repository.dart';
import 'package:shopping_list_app/core/services/firebase_auth_service.dart';
import 'package:shopping_list_app/core/services/firestore_db_service.dart';
//WIDGETLARIN KULLANDIKLARI SERVISLERIN DUZENLI HALDE CAGRILMASINI SAGLAR

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());  //lazy singleton ile ihtiyac olundugu an islem yapilir
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDbService());
}