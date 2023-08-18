import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'note_model.dart';

class AppDatabase{

  //singleton constructor
  AppDatabase._();
  static final AppDatabase db=AppDatabase._();

  static final Note_Table= "note";
  static final Note_column_ID="note_id";
  static final Note_column_Title="title";
  static final Note_column_Desc="desc";

  //create database variable
  Database? _database;

  //get DataBase Reference
  Future<Database> getDB()async{

    if(_database != null){
      return _database!;
    }else{
      // return await initDB();

      _database=await initDB();
      return _database!;
    }
  }

  //initialize DataBase
  Future<Database> initDB()async{
    Directory documentDirectory= await getApplicationDocumentsDirectory();
   var dbPath= join(documentDirectory.path,"noteDB.db");

   return openDatabase(
     dbPath,
     version: 1,
     onCreate:(db,version)async{
       //create table here
       db.execute("Create table $Note_Table($Note_column_ID integer primary Key autoincrement,$Note_column_Title text,$Note_column_Desc text) ");
     }
   );
  }


  Future<bool> addNote(NoteModel note )async{
  var d= await getDB();
    int rowsEffect= await d.insert(Note_Table, note.toMap());

    return rowsEffect>0;
  }


  Future<List<NoteModel>> fetchAllNotes()async{
    var d2= await getDB();
    List<Map<String,dynamic>>notes=await d2.query(Note_Table);
    List<NoteModel> listNotes=[];
    for(Map<String,dynamic> note in notes){
      listNotes.add(NoteModel.fromMap(note));
    }
    return listNotes;
  }


 Future<bool> updateNote(NoteModel note)async{
    var d3=await getDB();
    var count=await d3.update(Note_Table,note.toMap(),where: "$Note_column_ID =${note.id}");
    return count>0;
  }

  Future<bool> deleteNote(int id)async{
    var d4= await getDB();
    var count=await d4.delete(Note_Table,where: "$Note_column_ID=?",whereArgs: ["$id"]);

    return count>0;
  }

}