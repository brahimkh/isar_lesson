import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/db/isar/service/init_isar.dart';

import 'db/isar/model/student.dart';
import 'db/isar/service/student_impl_service.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  /// Flutter ensures that the main() method is called only once.
 await initDatabase();
 print("Starting app");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
Future<void> initDatabase()async{
  IsarService.init();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
   List<StudentCollection> students = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  void init()async{
    final studentService = StudentService();
    final listStudent = await studentService.getStudents();
    setState(() {
      students = listStudent;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Isar DB"),),
      body: Column(
        children: [
          const SizedBox(height: 40,),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          TextButton(onPressed: onSubmit,
              child: Text("Save Data")),
          Expanded(child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(students[index].name??""),
                subtitle: Text(students[index].age.toString()),
                trailing: Text(students[index].address??""),
              );

            },
          ))
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    final student = StudentCollection()
      ..name = _nameController.text
      ..age = int.parse(_ageController.text)
      ..address = _addressController.text;
    final studentService = StudentService();
    final value = await studentService.inputStudent(student);
    if (value == "Success") {
       init();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Data saved successfully"),));
    }
  }
}

