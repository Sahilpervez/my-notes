import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/src/model/note.dart';
import 'package:my_notes/src/services/local_db.dart';
import 'package:my_notes/src/views/create_note.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            padding: EdgeInsets.zero,
            onLongPress: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context, builder: (ctx){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  height: 100,
                  child: ListTile(
                    onTap: ()async{
                      final localDB = LocalDBService();
                      await localDB.deleteNote(note: note);
                      Navigator.of(context).pop();
                    },
                    leading: Icon(Icons.delete,color: const Color.fromARGB(255, 245, 111, 102)),
                    title: Text("Delete",style: GoogleFonts.poppins(color: const Color.fromARGB(255, 245, 111, 102))),));
              });
            },
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CreateNotesView(
                        note: note,
                      )));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.grey.shade300)),
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.title,
                          style: GoogleFonts.poppins(fontSize: 20,fontWeight: 
                          FontWeight.w500)),
                      Text(
                        note.description,
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ]),
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
