import 'package:hive/hive.dart';

import 'package:learning_hive_app/src/models_db/user.dart';

class Boxes {
  
  static Box<User> getUsers() => Hive.box<User>('users');

}