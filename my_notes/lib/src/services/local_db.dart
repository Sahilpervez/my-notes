import 'package:isar/isar.dart';
import 'package:my_notes/src/model/note.dart';

class LocalDBService{

  late Future<Isar> db;

  // Consturctor
  LocalDBService(){
    db = openDB();
  }

  Future<Isar> openDB()async{
    if(Isar.instanceNames.isEmpty){
      return await Isar.open([NoteSchema],inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveNote ({required Note note})async{
    final isar = await db;
    isar.writeTxnSync(() => isar.notes.putSync(note));
  }

  Stream<List<Note>> listenAllNotes ()async* {
    final isar = await db;
    yield* isar.notes.where().watch(fireImmediately: true);
  }

  Future<void> deleteNote ({required Note note})async{
    final isar = await db;
    isar.writeTxnSync(()=> isar.notes.deleteSync(note.id));
  }

}