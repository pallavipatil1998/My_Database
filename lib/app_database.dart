import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{

  //singleton constructor
  AppDataBase._();
  //class reference
  static final AppDataBase db=AppDataBase._();
  static final tableName= "info";
  static final column_Id= "id";
  static final column_Name= "name";
  static final column_Dept= "dept";

  //database reference
 Database? _database;

 //get Database
Future<Database>getDB()async{
  if(_database!=null){
    return _database!;
  }else{
    return await initDB();
  }
}

//initialize Dtabase
Future<Database> initDB()async{

  //create Database on path
  Directory a= await getApplicationDocumentsDirectory();
   var path= join(a.path,"infoDB.db");

   //create table
 return openDatabase(
      path,
      version: 1,
      onCreate: (db,version)async{
        db.execute("Create table $tableName($column_Id integer primary Key autoincrement,$column_Name text,$column_Dept text)");
      }
  );
}

//add infomation

Future<bool> addInfo(String nm ,String dp)async{
  //check Database
  var d1= await getDB();
  //add info row
  int rowsEffect= await d1.insert(tableName,{column_Name:nm,column_Dept:dp});

  //check row insert or not
  return rowsEffect>0;
}

Future<List<Map<String,dynamic>>> fetchAllInfo()async{
  //check database
  var d2=await getDB();
 List<Map<String,dynamic>> infoList = await d2.query(tableName);
  return infoList;
}


}