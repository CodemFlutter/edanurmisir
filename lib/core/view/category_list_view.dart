import 'package:flutter/material.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({ Key? key }) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text("Kategoriler Listesi")),
    );
  }
}