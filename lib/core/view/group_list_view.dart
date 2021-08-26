import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/constants/app_buttons.dart';
import 'package:shopping_list_app/constants/constants.dart';
import 'package:shopping_list_app/core/view/users_list_view.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({ Key? key }) : super(key: key);

  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
        body: Center(child:Column(
          children: [
            Text("Gruplar Sayfası"),
            AppButtons(buttonColor: pDarkest,
             buttonText: "sayfa gecisi deneme",
              textSize: 10,
              textColor: Colors.white,
              onPressed: ()=> Navigator.push(context, CupertinoPageRoute(builder: (context)=>UsersListPage())),
              )
          ],
        ) 
        )
    );
  }
}