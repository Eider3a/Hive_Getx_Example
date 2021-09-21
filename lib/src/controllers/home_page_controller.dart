

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:learning_hive_app/src/models_db/user.dart';
import 'package:learning_hive_app/src/utils/boxes.dart';

class HomePageController extends GetxController{

  List<User> _allUsers = [];

  List<User> get allUsers => this._allUsers;
  set allUsers(List<User> value) => this._allUsers = value;

  @override
  void onInit() {
    super.onInit();
    final usersBox = Boxes.getUsers();
    this._allUsers = usersBox.values.toList().cast<User>();
  }

  @override
  void onReady() {
    super.onReady();
    _refreshUI();
  }

  @override
  void onClose() {
    //! Cierra la box 'users'.
    Hive.box('users').close();

    //! Cierra todas las boxes.
    //Hive.close();
    super.onClose();
  }

  void _refreshUI(){
    final usersBox = Boxes.getUsers();
    this._allUsers = usersBox.values.toList().cast<User>();
    this._allUsers.forEach((e) {
      print('${e.key} => ${e.name}');

    });
    update();
  }

  //! ======== CRUD =========
  void addNewUser(User newUser) {
   final usersBox = Boxes.getUsers();
   //usersBox.put(key, value)//! Tengo que especificar el key el valor.
   usersBox.add(newUser); //! The key is automatically generated.
   _refreshUI();
  }

  void deleteUser(User userToDelete) {
    // Podemos usar este y el save metodo ya que nuestro modelo hereda de HiveObject.
    userToDelete.delete();
    print(userToDelete.key);
    _refreshUI();
  }


}