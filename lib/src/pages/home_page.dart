import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive/hive.dart';
import 'package:learning_hive_app/src/controllers/home_page_controller.dart';
import 'package:learning_hive_app/src/models_db/user.dart';

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  String name = "";
  String lastName = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (_) { 
        return Scaffold(
          appBar: AppBar(
            title: Text('Hive DB'),
          ),
          body: _createBodyContent(_),
          floatingActionButton: _createFloatingActionButton(_),
        );
      }
    );
  }

  Widget _createBodyContent(HomePageController _) {
    return ListView.builder(
      itemCount: _.allUsers.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 50.0),
      itemBuilder: (context, index) {
        final user = _.allUsers.elementAt(index);
        return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red,),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _.deleteUser(user);
          },
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text(user.name),
                subtitle: Text(user.lastName),
                trailing: GestureDetector(
                  onTap: (){
                    _.deleteUser(user);
                  },
                  child: Icon(Icons.delete, color: Colors.red,),
                ),
              ),
              // Divider()
            ],
          ),
        );
      },
    );
  }

  Widget _createFloatingActionButton(HomePageController _) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Get.defaultDialog(
          title: 'Add new user',
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Cancel')
            ),
            TextButton(
              onPressed: (){
                print(this.name);
                print(this.lastName);

                if (this.name.isEmpty || this.lastName.isEmpty) {
                  return Get.snackbar(
                    "Error",
                    "One of the fields is empty",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM
                  );
                }

                final newUser = new User(name: this.name, lastName: this.lastName, age: 23);
                _.addNewUser(newUser);
                this.name = "";
                this.lastName = "";
                Get.back();
              }, 
              child: Text('Add')
            )
          ],
          content: Column(
            children: [

              TextField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  this.name = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  this.lastName = value;
                },
              ),
              
            ],
          )
        );
      }
    );
  }

  
}