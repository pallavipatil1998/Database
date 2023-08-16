import 'package:my_database/app_database.dart';

class NoteModel{
  int? id;
  String title;
  String desc;

  //constructor
  NoteModel({this.id,required this.title,required this.desc});

   factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
         id: map[AppDatabase.Note_column_ID] ,
        title:map[AppDatabase.Note_column_Title] ,
        desc: map[AppDatabase.Note_column_Desc] ,
    );
  }


  Map<String,dynamic> toMap(){

     return {
       AppDatabase.Note_column_ID:id,
       AppDatabase.Note_column_Title:title,
       AppDatabase.Note_column_Desc:desc
     };
  }





}