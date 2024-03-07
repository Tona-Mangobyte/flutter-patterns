import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../services/note_service.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key, this.note});

  final NoteModel? note;

  @override
  _AddNoteViewState<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState <T extends AddNoteView> extends State<T> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('logging initState in AddNoteView');
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var noteService = context.read<NoteService>();
                      if (widget.note != null) {
                        noteService.update(NoteModel(
                          id: widget.note!.id,
                          title: _titleController.text,
                          content: _contentController.text,
                          completed: widget.note!.completed,
                        ));
                      } else {
                        noteService.add(NoteModel(
                          id: noteService.notes.length + 1,
                          title: _titleController.text,
                          content: _contentController.text,
                          completed: false,
                        ));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
