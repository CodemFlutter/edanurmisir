import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/constants/app_buttons.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/view/profile_view.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({ Key? key }) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context,listen:false);

    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcı Listesi"),),
      body:FutureBuilder<List<UserModel>>(
        future:_userViewModel.getAllUsers(),
        builder:(context,AsyncSnapshot<List<UserModel>> result){
          if(result.hasData){
            List<UserModel>? allUsers = result.data;
              if(allUsers!.length>1){     //kullanici sayisi 1'den buyukse (kendini gostermemesi icin)
                return ListView.builder(
                  itemCount: allUsers.length,
                  itemBuilder: (context,index){
                    var currentUser = result.data![index];
                    return Card(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(currentUser.photoURL),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${currentUser.firstName} ${currentUser.lastName}"),
                                Text(currentUser.userName!),
                                
                              ],),
                          ),
                          Spacer(),
                          PopupMenuButton(
                           itemBuilder: (context) => [
                            PopupMenuItem(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(user: currentUser)));
                              },
                              child: Text("Görüntüle")
                              ),
                             value: 1,
                          ),
                          PopupMenuItem(
                          child: Text("Sil"),
                          value: 2,
                        )
                ]
            )
                          
                      ],)
                      
                    );
                  }
                );
              }else return Center(child:Text("Kayıtlı kullanıcı yok"));
          }else{
            return Center(child: CircularProgressIndicator());
          }

        }
    )
    );
  }
}