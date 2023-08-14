import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/src/model/note.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key,required this.notes});
  final List<Note> notes;
  @override
  Widget build(BuildContext context) {
    return LiveGrid.options(itemBuilder: (context,index,animation)=> Container(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 16,mainAxisExtent: 16), itemCount: notes.length, options:const LiveOptions()) ;
  }
}