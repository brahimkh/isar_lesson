import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/student.dart';

class IsarService {
  IsarService._();

  late Future<Isar> _isar;
  static final _instance = IsarService._();

  factory IsarService ()=> _instance;

  static Future<Isar> get isar => _instance._isar;
  static Future<void> init() async {
    _instance._isar = _instance.openIsar();
  }

  Future<Isar> openIsar() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [StudentCollectionSchema],
        directory: dir.path,
        inspector:true,
      );
      return isar;
    } catch (e) {
      rethrow;
    }
  }
}
