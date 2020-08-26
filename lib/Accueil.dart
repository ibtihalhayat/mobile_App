import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/MainScreen.dart';
import 'package:mobile_app/profil.dart';
import 'package:mobile_app/acc.dart';

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
    Profil()
  ];


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
      ),
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

  void _onTappedItem(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  void _onPageChanged(int index){
    setState(() {
      selectedIndex = index;
    });
  }




}