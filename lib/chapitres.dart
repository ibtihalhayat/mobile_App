import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_app/Pdfviewerpage.dart';

import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/screens/module_listuser.dart';
import 'package:mobile_app/pdf_page.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class Chapitres extends StatefulWidget {

 // String _documentPath = 'assets/seance1.pdf';

  String nomCours;
  int nbChapitres;
  Chapitres({this.nomCours, this.nbChapitres});

  @override
  _ChapitresState createState() => _ChapitresState(nomCours, nbChapitres);
}

class _ChapitresState extends State<Chapitres> {


  String nomCours;
  int nbChapitres;
  _ChapitresState(this.nomCours, this.nbChapitres);


    @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(220, 234, 232, 1),
       body: Stack(
         children: [
          NestedScrollView(
            headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
             return <Widget>[
               SliverAppBar(
                  pinned: false,
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(220, 234, 232, 1),
                  expandedHeight: 175,
                  automaticallyImplyLeading: false,
                  title: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                       ),
                      child: Material(
                        color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                            CupertinoIcons.back,
                            size: 30,
                            color: Colors.red,
                            ),
                            ),
                            ),
                            ),
                 floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                       collapseMode: CollapseMode.parallax,
                        background: Padding(
                          padding: EdgeInsets.only(top: 30),
                           child: Image.asset("images/logo.png",
                             alignment: Alignment.topCenter,
                               fit: BoxFit.fitWidth,
                          ),
                          ),
                          ),
                          )
                          ];
                          },
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(54)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(
                  height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(nomCours,
                    style: TextStyle(
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                    color: Color(0xff121212)),
                    ),
                    ],
                    ),
                  SizedBox(
                  height: 25,
                  ),
                  Column(
                    children:<Widget> [
                      for(int i=1; i<=nbChapitres; i++) CustomTile(
                        title: "chapitre $i",num: i, nomCoursChoisi: nomCours,
                      )
                    ],
                  ),
                  SizedBox(
                  height: 110,
                  ),
                  ],
                  ),
                  ),
                  ),
                  ),
                  ],
                  ),
    );
  }

}



class CustomTile extends StatelessWidget {

  final nomCoursChoisi;
  final bool selected;
  final String title;
  final int num;
  //final String duration;
  const CustomTile({
    this.selected = false,
    this.title,
    this.num,
    this.nomCoursChoisi,
   // this.duration,
    Key key,
  }) : super(key: key);

  //static String get nomCours => nomCours;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap:(){
            Navigator.push(context, MaterialPageRoute(builder:
                (context) =>Pdfviewerpage(nomCourss: nomCoursChoisi,numChapitre: num,)));
          } ,
          leading: Container(
            margin: EdgeInsets.only(right: 15),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: selected ? Color(0xfff56c6b) : Colors.blueGrey,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Image.asset(
                  "images/start.png",
                  //color: selected ? Colors.white : Color.fromRGBO(220, 234, 232, 1),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w500,
              fontSize: 21,
              color: Color(0xff000000),
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        Divider(
          indent: 80,
          height: 20,
          color: Color(0xffD9D9D9).withOpacity(0.69),
          thickness: 1.5,
        )
      ],
    );
  }


}