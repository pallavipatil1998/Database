import 'package:flutter/material.dart';
import 'package:my_database/app_database.dart';

import 'note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _arrNotes = [];

  AppDatabase dbb = AppDatabase.db;

  // NoteProvider({required this.dbb});

  fetchNotes()async {
    _arrNotes= await dbb.fetchAllNotes();
    notifyListeners();
  }

  addNotes(NoteModel newNote) async{
    bool check =await dbb.addNote(newNote);
   if(check){
     fetchNotes();
     //or
    /* _arrNotes=await dbb.fetchAllNotes();
     notifyListeners();*/
   }
  }

  updateNotes(NoteModel note)async{
    bool check=await dbb.updateNote(note);
    if(check){
      fetchNotes();
    }
  }

  deleteNotes(int index){
    dbb.deleteNote(index);
    fetchNotes();
  }

  getNotes() {
   return _arrNotes;
  }
}
