import 'package:flutter/material.dart';
//import 'package:mobile_app/liste_utilisateurs.dart';
import 'package:mobile_app/profil.dart';
import 'package:mobile_app/acc.dart';
import 'package:mobile_app/screens/module_list.dart';
import 'package:mobile_app/screens/user_list.dart';

class Accueil extends StatefulWidget{

 // final FirebaseUser user;

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  int selectedIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [
    Acc(),
    UserList(),
    ModuleList(),
    Profil()
  ];


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedFontSize: 16,
        onTap: _onTappedItem,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Accueil'),
              backgroundColor : Colors.blueGrey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Utilisateurs'),
              backgroundColor : Colors.blueGrey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Modules'),
              backgroundColor : Colors.blueGrey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profil'),
              backgroundColor : Colors.blueGrey,
          )
        ],
      ),

     body: PageView(
       controller: _pageController,
       children: _screens,
       onPageChanged: _onPageChanged,
       physics: NeverScrollableScrollPhysics(),
     ),


    );

  }

  void _onTappedItem(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  void _onPageChanged(int index){
    setState(() {
      selectedIndex = index;
    });
  }




}