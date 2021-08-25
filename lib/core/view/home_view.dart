import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/constants/constants.dart';
import 'package:shopping_list_app/constants/textfieldDialog.dart';
import 'package:shopping_list_app/constants/ps_alert_dialog.dart';
import 'package:shopping_list_app/core/model/user_model.dart';
import 'package:shopping_list_app/core/view/profile_view.dart';
import 'package:shopping_list_app/core/view/shopping_wiew.dart';
import 'package:shopping_list_app/core/view/users_list_view.dart';
import 'package:shopping_list_app/core/viewmodel/user-view-model.dart';
import 'category_list_view.dart';


// OTURUM ACMIS KULLANICILARIN GORECEGI SAYFA
class HomePage extends StatefulWidget {
  final UserModel? user;
  HomePage({ Key? key , required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
       int secilenIndeks=0;
  

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double h = screenInfo.size.height;
  final double w = screenInfo.size.width;
     var drawerList = <Widget>[ShoppingPage(user:widget.user),
      ProfilePage(user: widget.user),
      UsersListPage(),CategoryListPage()];  //kisinin kategorilerini icerir

    return Scaffold(
      
     appBar:AppBar(),
        
      body: drawerList[secilenIndeks],
      drawer:Drawer(
        child:Container(
          color: background.withOpacity(0.5),
          child: ListView(
            padding: EdgeInsets.zero, //headerın en uste sabitlenmesi icin
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height:70,width:70,
                      child: CircleAvatar(backgroundImage: NetworkImage(widget.user!.photoURL),)),
                    Text("${widget.user!.userName}",style:TextStyle(color:background)),

                  ],
                ),
                decoration: BoxDecoration(
                  color: pMain,
                )
              ),

              ListTile( //kisisel listeye gider. login yapmadan da erisilebilir
                leading: Icon(Icons.list_alt_rounded, color:pDarkest),
                 title: Text("Kişisel Listem",style:TextStyle(fontSize: 15)),
                 onTap: (){
                   setState(() {
                     secilenIndeks = 0;
                     Navigator. pop(context) ;
                   });

                 },
                ),

                

              ListTile( //aile grubunun oldugu listelere gider. yalniz giris yapilmissa erisilir
                
                leading: Icon(Icons.library_books, color:pDarkest),
                title: Text("Profilim",style:TextStyle(fontSize: 15)),
                 onTap: (){
                   setState(() {
                     
                     Navigator.pop(context);
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfilePage(user: widget.user)));
                   });
                 },
                
              ),


              ListTile(   //Grup ekle secenegi ile alert dialog belirir
                leading: Icon(Icons.add, color:pDarkest),
                title: Text("Grup Ekle",style:TextStyle(fontSize: 15)),
                 onTap: (){
                   setState(() {
                    
                     Navigator. pop(context) ;
                     
                     showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                            return Container(
                              width:h/3,
                              height:w-40,
                              child: TextFieldDialog(h: h, w: w),
                            );
                          },
                        );
                      
                    
                   });
                 },
                
              ),

              ListTile(
                leading: Icon(Icons.logout, color:pMain),
                title: Text("Çıkış",style:TextStyle(fontSize: 15, color:pMain)),
                 onTap: (){

                _cikisOnayiIste(context);
                  
                 },
                
              ),
              Visibility(
                visible:widget.user!.role=="admin"?true:false,
                child: ListTile( //kisisel listeye gider. login yapmadan da erisilebilir
                  leading: Icon(Icons.list_alt_rounded, color:pDarkest),
                   title: Text("Kullanıcı Listesi",style:TextStyle(fontSize: 15)),
                   onTap: (){
                     setState(() {
                       Navigator.pop(context);
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>UsersListPage()));
                     });
              
                   },
                  ),
              ),
                Visibility(
                  visible:widget.user!.role=="admin"?true:false,
                  child: ListTile( //kisisel listeye gider. login yapmadan da erisilebilir
                  leading: Icon(Icons.list_alt_rounded, color:pDarkest),
                   title: Text("Kategori Listesi",style:TextStyle(fontSize: 15)),
                   onTap: (){
                     setState(() {
                       secilenIndeks = 3;
                       Navigator. pop(context) ;
                     });
                
                   },
                  ),
                ),
            ],
          ),
        )
        )
    );
  }
  

  AppBar buildAppBar(int sIndeks) {
    return AppBar(
      
      elevation: 0,
      title:(sIndeks==0)?Text("Alışveriş Listelerim"):Text(" "),
  );
  
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen:false);
    bool sonuc = await _userViewModel.signOut();
    return sonuc;
  }

 Future _cikisOnayiIste(BuildContext context)async {
    final _sonuc =await  PsAlertDialog(
      title:"Çıkış Onayı" ,
      message: "Oturumu kapatmak istediğinize emin misiniz?",
      mainButton: "EVET",
      closeButton: "İPTAL",
      ).goster(context);
      if(_sonuc==true){
        _cikisYap(context);
      }
  }
  

}

