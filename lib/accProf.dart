import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:mobile_app/screens/module_list.dart';
import 'package:mobile_app/screens/module_listuser.dart';


class AccProf extends StatefulWidget {
  const AccProf({Key key}) : super(key: key);

  @override
  _AccProfState createState() => _AccProfState();
}

class _AccProfState extends State<AccProf> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          padding: EdgeInsets.fromLTRB(25.0, 155.0, 20.0, 0.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),


              color: Colors.transparent
          ),
          child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(text: 'Ajouter module.',
                      //  recognizer: TapGestureRecognizer()..onTap = handleSignIn,
                      recognizer: TapGestureRecognizer()..onTap = () {
                        debugPrint('FAB clicked');
                        navigateToDetailm(Module('', ''), 'Add Module');
                      }
                      ,

                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                      )
                  )
                ]
            ),


          )
      ),
    );
  }


  void navigateToDetailm(Module module, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ModuleDetail(module, title);
    }));

  }

}

