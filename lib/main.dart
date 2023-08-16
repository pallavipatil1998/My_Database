import 'package:database_1/app_database.dart';
import 'package:flutter/material.dart';

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
      home:const FirstScreen()
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late AppDataBase myDB;
  List<Map<String,dynamic>> infomList=[];

  @override
  void initState() {
    super.initState();
    myDB=AppDataBase.db;
    //fetch all data
    enterInfo();
  }

  void enterInfo()async{
    bool check = await myDB.addInfo("pallavi", "Flutter Developer");

    if(check) {
      infomList = await myDB.fetchAllInfo();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Info DataBase'),),
      body: ListView.builder(
        itemCount: infomList.length,
          itemBuilder: (context,index){
          return ListTile(
            title: Text('${infomList[index]["name"]}'),
            subtitle:Text('${infomList[index]["dept"]}'),
          );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          enterInfo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


