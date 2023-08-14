import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:my_notes/src/model/note.dart';
import 'package:my_notes/src/services/local_db.dart';

class CreateNotesView extends StatefulWidget {
  const CreateNotesView({super.key, this.note});

  final Note? note;

  @override
  State<CreateNotesView> createState() => _CreateNotesViewState();
}

class _CreateNotesViewState extends State<CreateNotesView> {
  final localDB = LocalDBService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.note !=null){
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    print(_titleController.text);
    print(_descriptionController.text);
    final title = _titleController.text;
    final description = _descriptionController.text;
    
    if(widget.note != null){
      final newNote = widget.note!.copyWith(
        title: title,description: description
      );
        localDB.saveNote(note: newNote);

        return;
    }

    if(title.isEmpty && description.isEmpty){
      return;
    }
    
    final Note newNote = Note(
        title: (title.isEmpty)? "title":title,
        description: (description.isEmpty)?"discription":description,
        id: Isar.autoIncrement,
        lastModified: DateTime.now());
    localDB.saveNote(note: newNote);


    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Title"),
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _descriptionController,
              minLines: 1,maxLines: 10,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Description"),
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          ),
        ],
      )),
    );
  }
}
