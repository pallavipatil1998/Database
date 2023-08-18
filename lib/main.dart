import 'package:flutter/material.dart';
import 'package:my_database/app_database.dart';
import 'package:my_database/note_provider.dart';
import 'package:my_database/second_page.dart';
import 'package:provider/provider.dart';

import 'note_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => NoteProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(title: "My DataBase",),
    );
  }
}


class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key});
 String title;
 MyHomePage({required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NoteModel> arrNotes=[];

  var titleController=TextEditingController();
  var descController=TextEditingController();

  //get all notes
  getAllNotes(BuildContext context)async{
    context.read<NoteProvider>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    getAllNotes(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Consumer<NoteProvider>(
        builder: (_,provider,__){
          return  ListView.builder(
              itemCount:provider.getNotes().length,

              itemBuilder:(ctx ,index){
                var currData=provider.getNotes()[index];

                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(isUpdate: true,title: currData.title,desc: currData.desc),));
                  },
                  child: ListTile(
                    title: Text(currData.title),
                    subtitle: Text(currData.desc),
                    trailing: InkWell(
                        onTap: ()async{
                         context.read<NoteProvider>().deleteNotes(index);
                        },
                        child: Icon(Icons.delete,color: Colors.red,)),
                  ),
                );

              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(isUpdate: false,),));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}

