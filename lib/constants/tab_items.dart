import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {Personal,Group}

class TabItemData{
  final String label;
  final IconData icon;
  TabItemData(this.icon,this.label);

  static Map<TabItem, TabItemData> tumTablolar = {
    TabItem.Personal: TabItemData(Icons.list,"Listem"),
    TabItem.Group: TabItemData(Icons.supervised_user_circle,"Grup Listelerim"),
  };


}