import 'package:flutter/foundation.dart';
import 'package:simple_demo/models/note_model.dart';

class NoteService with ChangeNotifier {
  late List<NoteModel> _notes;
  NoteService() {
    _notes = [
      NoteModel(
        id: 1,
        title: 'Note 1',
        content: 'Content 1',
        completed: false,
      ),
      NoteModel(
        id: 2,
        title: 'Note 2',
        content: 'Content 2',
        completed: false,
      ),
      NoteModel(
        id: 3,
        title: 'Note 3',
        content: 'Content 3',
        completed: false,
      ),
      NoteModel(
        id: 4,
        title: 'Note 4',
        content: 'Content 4',
        completed: false,
      ),
    ];
  }

  get notes => _notes;

  void add(NoteModel note) {
    _notes.add(note);
    print('logging add note success ${_notes.length}');
    notifyListeners();
  }

  void remove(NoteModel note) {
    _notes.remove(note);
    print('logging remove note success ${_notes.length}');
    notifyListeners();
  }

  void update(NoteModel note) {
    _notes[_notes.indexWhere((element) => element.id == note.id)] = note;
    print('logging update note success ${_notes.length}');
    notifyListeners();
  }
}