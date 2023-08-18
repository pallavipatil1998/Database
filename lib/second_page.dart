import 'package:flutter/material.dart';
import 'package:my_database/note_model.dart';
import 'package:my_database/note_provider.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  String? title;
  String? desc;
  bool isUpdate = false;

  AddNotePage({required this.isUpdate, this.title, this.desc});

  var titleController = TextEditingController();
  var descController = TextEditingController();
  String OperationTitle = "Add Note";

  void addNote(String title, String desc, BuildContext context) {
    context.read<NoteProvider>().addNotes(NoteModel(title: title, desc: desc));
  }

  void updateNote(String title,String desc,BuildContext context){
  context.read<NoteProvider>().updateNotes(NoteModel(title: title, desc: desc));
  }

  initControllers() {
    titleController.text = title!;
    descController.text = desc!;
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      initControllers();
      OperationTitle = "Update Note";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(OperationTitle),
      ),

      body: Container(
        height: 400,
        child: Column(
          children: [
            Text(OperationTitle),
          TextField(
          controller: titleController,),
            TextField(controller:descController,),
            ElevatedButton(
                onPressed: (){
                  var title=titleController.text.toString();
                  var desc=descController.text.toString();

                  if(isUpdate){
                    updateNote(title, desc, context);
                  }else{
                    addNote(title, desc, context);
                  }

                  Navigator.pop(context);

                },
                child: Text(OperationTitle)
            ),
          ],
        ),
      ),
    );
  }
}
