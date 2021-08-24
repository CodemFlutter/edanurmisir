import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({ Key? key }) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child:Text("Kullanıcılar Listesi")),
    );
  }
}