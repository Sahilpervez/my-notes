import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/src/model/note.dart';
import 'package:my_notes/src/res/strings.dart';
import 'package:my_notes/src/services/local_db.dart';
import 'package:my_notes/src/views/create_note.dart';
import 'package:my_notes/src/views/widgets/empty_view.dart';
import 'package:my_notes/src/views/widgets/note_list.dart';
import 'package:my_notes/src/views/widgets/notes_grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const CreateNotesView()));
          }, child: const Icon(Icons.add),),
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.appName,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                  ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    isListView = !isListView;
                  });
                }, icon: Icon((isListView)?Icons.splitscreen_outlined:Icons.grid_view_outlined))
              ],
            ),
          ),
          // const EmptyView(),
          StreamBuilder<List<Note>>(
            stream: LocalDBService().listenAllNotes(),
            builder: (context, snapshot) {
              if(snapshot.data == null){
                return const EmptyView();
              }
              final notes = snapshot.data;
              if(notes!.isEmpty){
                return const EmptyView();
              }
             return (isListView)?
             NotesListBuilder(notes: notes):NotesGrid(notes: notes);
            }
          )
        ],
      )),
    );
  }
}
