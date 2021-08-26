import 'package:flutter/material.dart';
import 'package:shopping_list_app/core/model/user_model.dart';

class PersonalListPage extends StatefulWidget {
  UserModel? user;
 PersonalListPage({ Key? key, required this.user }) : super(key: key);

  @override
  _PersonalListPageState createState() => _PersonalListPageState();
}

class _PersonalListPageState extends State<PersonalListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(child:Text("${widget.user!.userName} listesi"))
      ),
    );
  }
}