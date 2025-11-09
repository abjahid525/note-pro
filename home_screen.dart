import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_pro/screens/note_editor.dart';
import 'package:notes_pro/screens/note_reader.dart';
import 'package:notes_pro/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        elevation: 2,
        title: Text("Notes Pro", style: GoogleFonts.roboto(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent notes",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20.0),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children:
                          snapshot.data!.docs
                              .map((note) => noteCard(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReaderScreen(note)));
                          }, note))
                              .toList(),
                    );
                  }
                  return Text(
                    "there's no Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.cyan.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
      ),
    );
  }
}
