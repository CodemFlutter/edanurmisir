import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/constants/tab_items.dart';

class AdminBottomNavigation extends StatelessWidget {
  const AdminBottomNavigation({ Key? key, required this.currentTab, required this.onSelectedTab, required this.pageCreator }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem?,Widget> pageCreator;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar:CupertinoTabBar(
        items: [
          _navItemOlustur(TabItem.Personal),
          _navItemOlustur(TabItem.Group)
        ]
        ),
      
      tabBuilder: (context,index){
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
          builder: (context){
            return pageCreator[gosterilecekItem]!;
          },
        );
        

      },
          
    );
  }
  BottomNavigationBarItem _navItemOlustur(TabItem tabItem){
    final olusturulacakTab = TabItemData.tumTablolar[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab!.icon),
      label:olusturulacakTab.label
    );
  }

  
}
