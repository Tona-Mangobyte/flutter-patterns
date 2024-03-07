import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../services/note_service.dart';
import 'add_note_view.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  _NoteViewState<NoteView> createState() => _NoteViewState();
}

class _NoteViewState<T extends NoteView> extends State<T> {

  @override
  void initState() {
    super.initState();
    print('logging initState in NoteView');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Note'),
      ),
      body: Container(
        child: Consumer<NoteService>(
          builder: (context, noteService, child) {
            return ListView.builder(
              itemCount: noteService.notes.length,
              itemBuilder: (context, index) {
                return _buildItem(noteService.notes[index], index);
              },
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddNoteScreen(context, null);
          print("logging Add Note");
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItem(NoteModel note, int index) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: note.completed,
          onChanged: (value) {
            print('logging Checkbox changed to $value');
          },
        ),
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          print('logging Tapped on $index');
          _navigateToAddNoteScreen(context, note);
        },
      ),
    );
  }

  void _navigateToAddNoteScreen(BuildContext context, NoteModel? note) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNoteView(note: note)));
  }
}
