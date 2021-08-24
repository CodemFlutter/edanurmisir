import 'package:flutter/material.dart';
import 'package:shopping_list_app/core/model/user_model.dart';

class ShoppingPage extends StatefulWidget {
  UserModel? user;
 ShoppingPage({ Key? key, required this.user }) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(child:Text("${widget.user!.userName} listesi"))
      ),
    );
  }
}