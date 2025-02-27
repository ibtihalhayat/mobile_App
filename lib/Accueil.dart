import 'package:flutter/material.dart';
//import 'package:mobile_app/liste_utilisateurs.dart';
import 'package:mobile_app/profil.dart';
import 'package:mobile_app/acc.dart';
import 'package:mobile_app/screens/module_list.dart';
import 'package:mobile_app/screens/user_list.dart';

class Accueil extends StatefulWidget{
  String nomUser;
  String emailUser;
  Accueil({this.nomUser, this.emailUser});

 // final FirebaseUser user;

  @override
  _AccueilState createState() => _AccueilState(nomUser,emailUser);
}

class _AccueilState extends State<Accueil> {

  String nomUser;
  String emailUser;
  _AccueilState(this.nomUser, this.emailUser);

  int selectedIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [  // La Barre qui s'affiche en bas de la page
    Acc(),
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

  // fonction qui sert à se déplacer entre les pages qui sont dans la barre en bas de la page
  void _onTappedItem(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  // fonction qui change l'index courant selon la pagenchoisie
  void _onPageChanged(int index){
    setState(() {
      selectedIndex = index;
    });
  }




}