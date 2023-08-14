import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:my_notes/src/model/note.dart';
import 'package:my_notes/src/res/assets.dart';
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
  bool _isDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note != null) {
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

    if(_isDelete){
      return;
    }


    if (widget.note != null) {
      final newNote =
          widget.note!.copyWith(title: title, description: description);
      localDB.saveNote(note: newNote);

      return;
    }

    if (title.isEmpty && description.isEmpty) {
      return;
    }

    final Note newNote = Note(
        title: (title.isEmpty) ? "title" : title,
        description: (description.isEmpty) ? "discription" : description,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                if (widget.note != null)
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Do you want to delete this note",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                    )),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(AppAnimations.delete),
                                    Text("This note will be permanently deleted!",
                                    style: GoogleFonts.poppins(fontSize: 18))
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.poppins(
                                            color: Colors.green, fontSize: 17),
                                      )),
                                  TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        setState(() {
                                          _isDelete = true;
                                        });
                                        final localDB = LocalDBService();
                                        localDB.deleteNote(note: widget.note!);
                                      },
                                      icon: Icon(Icons.delete_outline,color: Colors.red),
                                      label: Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                            color: Colors.red, fontSize: 17),
                                      )),
                                ],
                              );
                            });
                        // Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.delete)),
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
              minLines: 1,
              maxLines: 10,
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
