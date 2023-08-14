import 'package:flutter/material.dart';
import 'package:my_notes/src/model/note.dart';
import 'package:my_notes/src/views/widgets/note_list_item.dart';

class NotesListBuilder extends StatelessWidget {
  const NotesListBuilder({super.key,required this.notes});
  final List<Note> notes ;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: notes!.length,
                    itemBuilder: (ctx,idx){
                    return NoteListItem(note: notes[idx],);
                  }),
    );
  }
}