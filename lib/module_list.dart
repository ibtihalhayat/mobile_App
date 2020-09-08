/*import 'package:mobile_app/db/database_provider_module.dart';
import 'package:mobile_app/events/delete_module.dart';
import 'package:mobile_app/events/set_modules.dart';
import 'package:mobile_app/events/update_module.dart';
import 'package:mobile_app/inscription_module.dart';
import 'package:mobile_app/models/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/module_bloc.dart';

class ModuleList extends StatefulWidget {
  const ModuleList({Key key}) : super(key: key);

  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getModules().then(
          (moduleList) {
        BlocProvider.of<ModuleBloc>(context).add(SetModules(moduleList));
      },
    );
  }

  showModuleDialog(BuildContext context, Module module, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(module.nom),
        content: Text("ID ${module.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ModuleForm(module: module, moduleIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(module.id).then((_) {
              BlocProvider.of<ModuleBloc>(context).add(
                DeleteModule(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire user list scaffold");
    return Scaffold(
      body: Container(
        child: BlocConsumer<ModuleBloc, List<Module>>(
          builder: (context, moduleList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                print("moduleList: $moduleList");

                Module module = moduleList[index];
                return ListTile(
                    title: Text(module.nom, style: TextStyle(fontSize: 30)),
                    subtitle: Text(
                      "NbChapitres: ${module.nbchapitres}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showModuleDialog(context, module, index));
              },
              itemCount: moduleList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, moduleList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ModuleForm()),
        ),
      ),
    );
  }
}
*/