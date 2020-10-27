import 'package:flutter/material.dart';
import 'package:mobile_app/accProf.dart';
//import 'package:mobile_app/liste_utilisateurs.dart';
import 'package:mobile_app/profil.dart';
import 'package:mobile_app/acc.dart';
import 'package:mobile_app/screens/module_list.dart';
import 'package:mobile_app/screens/user_list.dart';

class AccueilProf extends StatefulWidget{
  String nomUser;
  String emailUser;
  AccueilProf({this.nomUser, this.emailUser});

  // final FirebaseUser user;

  @override
  _AccueilProfState createState() => _AccueilProfState(nomUser,emailUser);
}

class _AccueilProfState extends State<AccueilProf> {

  String nomUser;
  String emailUser;
  _AccueilProfState(this.nomUser, this.emailUser);

  int selectedIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [ // La Barre qui s'affiche en bas de la page
    AccProf(),
    UserList(),
    ModuleList()
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
              title: Text('Etudiants'),
              backgroundColor : Colors.blueGrey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Modules'),
              backgroundColor : Colors.blueGrey
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

  // fonction qui change l'index courant selon la page choisie
  void _onPageChanged(int index){
    setState(() {
      selectedIndex = index;
    });
  }




}