// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_collection_literals, deprecated_member_use, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/boxes.dart';
import 'package:todo_app/models/todo.dart';
import '../widgets/bottom_sheet.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 232, 243),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        elevation: 0.3,
        backgroundColor: Color.fromARGB(255, 114, 139, 248),
        title: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text("What's up for today?",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w800,),),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>(HiveBoxes.todo).listenable(),
        builder: (context, Box<Todo> box, _){
          if(box.values.isEmpty){
            return Center(
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  'To add a task a simple task, click on \n the add button below.',
                  textAlign: TextAlign.center,
                  ),
                ),
            );
          }
          return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index){
            Todo? res = box.getAt(index);
            return Dismissible(
              onDismissed: (direction) {
                res!.delete();
              },
              background: Container(color: Color.fromARGB(255, 252, 170, 164),),
              key: UniqueKey(), 
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    //trailing: IconButton(onPressed: (){res!.delete();}, icon: Icon(Icons.delete_outline_outlined)),
                    title: Text(res!.title,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal,),),
                  ),
                ),
              ),
              );
          }
          );
        },
        
      ),
      floatingActionButton: bottomSheet(), //check widget folder for bottomsheet class
    );
  }
}
