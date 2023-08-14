import 'package:flutter/material.dart';
import 'package:my_database/app_database.dart';

void main() {
  runApp(const MyApp());
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
  late AppDatabase myDB;
  List<Map<String,dynamic>>arrData=[];

  var titleController=TextEditingController();
  var descController=TextEditingController();

  @override
  void initState() {
    super.initState();
    myDB=AppDatabase.db;
   getAllNotes();
  }

  //get all notes
  getAllNotes()async{
    arrData=await myDB.fetchAllNotes();
    setState(() {});
  }

  //add note
  enterNote(String title,String desc)async {
    bool check = await myDB.addNote(title,desc);
    if (check) {
      arrData = await myDB.fetchAllNotes();
      setState(() {
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: ListView.builder(
        itemCount: arrData.length,
          itemBuilder:(ctx ,index){
           return ListTile(
             title: Text(arrData[index]["title"]),
             subtitle: Text('${arrData[index]["desc"]}')
           );

          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        showModalBottomSheet(
            context: context,
            builder: (cntext){
              return Container(
                margin: EdgeInsets.all(20),
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Add Note",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextField(
                      controller:titleController ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(21),),
                        hintText: "Enter Title",
                        label: Text("Title")
                      ),
                    ),
                    TextField(
                      controller:descController ,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                          hintText: "Enter desc",
                          label: Text("Desc")
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          var title =titleController.text.toString();
                          var desc=descController.text.toString();
                         enterNote(title,desc);
                         titleController.clear();
                         descController.text="";
                             Navigator.pop(context);
                        },
                        child: Text("Add")
                    )
                  ],
                ),
              ) ;
            }
        );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

