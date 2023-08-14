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
      home:MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppDatabase myDB;
  List<Map<String,dynamic>>arrData=[];

  @override
  void initState() {
    super.initState();
    myDB=AppDatabase.db;
    enterNote();
  }
  enterNote()async {
    bool check = await myDB.addNote("Flutter", "Mobile Application");

    if (check) {
      arrData = await myDB.fetchAllNotes();
      setState(() {
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Database"),),
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

        },
        child: Icon(Icons.add),
      ),
    );
  }
}

