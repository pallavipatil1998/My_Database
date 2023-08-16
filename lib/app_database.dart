import 'dart:io';

import 'package:database_1/info_model.dart';
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
Future<bool> addInfo(InfoModel info)async{
  //check Database
  var d1= await getDB();
  //add info row
  int rowsEffect= await d1.insert(tableName,info.toMap());

  //check row insert or not
  return rowsEffect>0;
}

//get all Information
Future<List<InfoModel>> fetchAllInfo()async{
  //check database
  var d2=await getDB();
 List<Map<String,dynamic>> arrList = await d2.query(tableName);
 List<InfoModel> infoList=[];

 for(Map<String,dynamic> info in arrList){
   infoList.add(InfoModel.fromMap(info));
 }

  return infoList;
}

//Update Information
Future<bool>update(InfoModel info)async{
  var d3=await getDB();
  int count =await d3.update(tableName, info.toMap(), where: "$column_Id=${info.id}");
  return count>0;
}

//Delete Information
Future<bool>delete(int id)async{
  var d4=await getDB();

  var count=await d4.delete(tableName,where:"$column_Id=?" ,whereArgs:[id]);
  return count>0;
}


}