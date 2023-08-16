import 'package:database_1/app_database.dart';

class InfoModel{
  int? id;
  String name;
  String dept;

  InfoModel({this.id,required this.name,required this.dept});

  factory InfoModel.fromMap(Map<String,dynamic>map){
    return InfoModel(
        id: map[AppDataBase.column_Id],
        name: map[AppDataBase.column_Name],
        dept: map[AppDataBase.column_Dept]
    );
  }

 Map<String,dynamic> toMap(){

    return{
      AppDataBase.column_Id:id,
      AppDataBase.column_Name:name,
      AppDataBase.column_Dept:dept,
    };
  }


}