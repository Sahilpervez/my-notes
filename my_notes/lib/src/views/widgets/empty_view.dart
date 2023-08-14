import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_notes/src/res/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(AppAnimations.empty),
        Text("Things look Empty here, Tap + to start",style: GoogleFonts.poppins(fontSize: 18
        ))
      ],
    );
  }
}