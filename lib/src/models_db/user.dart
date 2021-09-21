import 'package:hive/hive.dart';

part 'user.g.dart';

//! Comando de hive para generar los adapters.
//! Se usa luego de crear el modelo y agregarle las anotaciones.
//!>> flutter packages pub run build_runner build

@HiveType(typeId: 0)
class User extends HiveObject{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final int age;

  User({
    required this.name, 
    required this.lastName, 
    required this.age
  });

}