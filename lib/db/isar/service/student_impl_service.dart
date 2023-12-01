import 'package:isar/isar.dart';
import 'package:untitled/db/isar/model/student.dart';

import 'init_isar.dart';

class StudentService{
  late Future<Isar> _isar;
   StudentService(){
     _isar = IsarService.isar;
   }
  Future<String> inputStudent(StudentCollection student)async{
     try{
       final isar = await _isar;
        await isar.writeTxn(()=>isar.studentCollections.put(student));
        return "Success";
     }catch(e){
       return e.toString();
     }
  }
  Future<List<StudentCollection>> getStudents()async{
    try{
      final isar = await _isar;
      final students = await isar.studentCollections.where().findAll();
      return students;

    }catch(e){
      rethrow;
    }
  }
}
