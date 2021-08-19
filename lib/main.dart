import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/constants/constants.dart';
import 'package:shopping_list_app/core/locator.dart';
import 'package:shopping_list_app/core/view/landing_view.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();    //firebase baslangicta durum kontrolleri icin initialize edilmeli 
  setupLocator();                     //locator (get it paketi) icin baslangic cagrisi
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> UserViewModel(), 
      child: MaterialApp(
        title: 'Shopping List App',
        theme: ThemeData(
          primaryColor: pMain,
        ),
          home: LandingPage(),         
      ),
    );
  }
}



