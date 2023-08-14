import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/src/model/note.dart';
import 'package:my_notes/src/views/create_note.dart';

class NotesGridItem extends StatelessWidget {
  const NotesGridItem({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateNotesView(
                  note: note,
                )));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.zero,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: GoogleFonts.poppins(fontSize: 18),
                    maxLines: 1,
                  ),
                  Flexible(
                    child: Text(
                      note.description,
                      style: GoogleFonts.poppins(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
