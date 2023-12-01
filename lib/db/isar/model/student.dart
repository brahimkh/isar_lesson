import 'package:isar/isar.dart';
part 'student.g.dart';
@Collection()
class StudentCollection{
  Id id = Isar.autoIncrement;
  String? name;
  int? age;
  String? address;
}