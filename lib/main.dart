import 'package:database_1/app_database.dart';
import 'package:database_1/info_model.dart';
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
  List<InfoModel> infomList=[];

  var nameController =TextEditingController();
  var deptController =TextEditingController();

  @override
  void initState() {
    super.initState();
    myDB=AppDataBase.db;
    //fetch all data
    getAllInfo();
  }

  void enterInfo(String name1,String dept1)async{
    bool check = await myDB.addInfo(InfoModel(name: name1, dept: dept1));

    if(check) {
      infomList = await myDB.fetchAllInfo();
      setState(() {});
    }
  }

  getAllInfo()async{
   infomList= await myDB.fetchAllInfo();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Info DataBase'),),
      body: ListView.builder(
        itemCount: infomList.length,
          itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              nameController.text=infomList[index].name;
              deptController.text=infomList[index].dept;
              //for update Button
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return Container(
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Update Data'),
                            TextField(
                              onTap: (){},
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: "Enter Name",
                                  label: Text('Name'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                            ),
                            TextField(
                              onTap: (){},
                              controller: deptController,
                              decoration: InputDecoration(
                                  hintText: "Enter Department",
                                  label: Text('Department'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                            ),

                            ElevatedButton(
                                onPressed: ()async{
                                  //get value from conntroller
                                  var name2=nameController.text.toString();
                                  var dept2=deptController.text.toString();
                                  await myDB.update(InfoModel(id: infomList[index].id!,name: name2, dept: dept2));

                                  getAllInfo();
                                  //set empty controller
                                  nameController.clear();
                                  deptController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text("Update")
                            )
                          ],
                        ),
                      );
                    }
                );
              },


            child: ListTile(
              leading: Text('${infomList[index].id!}'),
              title: Text('${infomList[index].name}'),
              subtitle:Text('${infomList[index].dept}'),
              trailing: InkWell(
                onTap: ()async{
                  await myDB.delete(infomList[index].id!);
                  getAllInfo();
                },
                  child: Icon(Icons.delete,color: Colors.red,)),
            ),
          );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         showModalBottomSheet(
             context: context,
             builder: (context){
               return Container(
                 height: 500,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text('Add Data'),
                     TextField(
                       onTap: (){},
                       controller: nameController,
                       decoration: InputDecoration(
                         hintText: "Enter Name",
                         label: Text('Name'),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10)
                         )
                       ),
                     ),
                     TextField(
                       onTap: (){},
                       controller: deptController,
                       decoration: InputDecoration(
                           hintText: "Enter Department",
                           label: Text('Department'),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10)
                           )
                       ),
                     ),

                      ElevatedButton(
                          onPressed: (){
                            //get value from conntroller
                            var name2=nameController.text.toString();
                            var dept2=deptController.text.toString();
                            enterInfo(name2,dept2,);

                            //set empty controller
                            nameController.clear();
                            deptController.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Add")
                      )
                   ],
                 ),
               );
             }
         );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


