import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  //singleton constructor
  AppDatabase._();
  static final AppDatabase db=AppDatabase._();

  //create database variable
  Database? _database;

  //get DataBase Reference
  Future<Database> getDB()async{

    if(_database != null){
      return _database!;
    }else{
      return await initDB();
    }
  }

  //initialize DataBase
  Future<Database>initDB()async{
    Directory documentDirectory= await getApplicationDocumentsDirectory();
   var dbPath= join(documentDirectory.path,"noteDB.db");

   return openDatabase(
     dbPath,
     version: 1,
     onCreate:(db,version){
       //create table here
       db.execute("Create table note(note_id integer primary Key autoincrement,title text,desc text) ");
     }
   );
  }


  Future<bool>addNote(String titl,String des )async{
  var d= await getDB();
    int rowsEffect= await d.insert("note", {"title":titl,"desc":des});

    if(rowsEffect>0){
      return true;
    }else{
      return false;
    }

    // return rowsEffect>0;
  }


  Future<List<Map<String,dynamic>>>fetchAllNotes()async{
    var d2= await getDB();
    List<Map<String,dynamic>>notes=await d2.query("note");
    return notes;
  }

}