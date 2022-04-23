// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/boxes.dart';
import 'package:todo_app/models/todo.dart';

class bottomSheet extends StatefulWidget {
  const bottomSheet({ Key? key }) : super(key: key);

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {

  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  late String title;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 114, 139, 248),
      child: Icon(Icons.add_rounded,size: 40,),
      onPressed: (){
        showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                backgroundColor: Colors.white,
                isScrollControlled: true,
                isDismissible: true,
                context: context, 
                builder: (context){
                  return Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 26,horizontal: 18),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Form(
                                key: formKey,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  //controller: textController,
                                  validator: (value){
                                    if (value != null && value.isEmpty){
                                      return 'Text field cannot be empty';
                                    }
                                  },
                                  onChanged: (value) {
                                    title = value;
                                  },
                                  autofocus: true,
                                  cursorColor: Colors.black87,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: (){
                                        final isValidForm = formKey.currentState!.validate();
                                        if(isValidForm){
                                          _onFormSubmit();
                                        }
                                    }, icon: Icon(Icons.send_rounded,color: Colors.black87,)),
                                    border: InputBorder.none,
                                    hintText: 'What are your plans?',
                                    hintStyle: TextStyle(fontSize: 16,)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ),
                      ),
                    ],
                  );
                },
              );
         },
      );
  }

  void _onFormSubmit(){
    Box<Todo> todoBox = Hive.box<Todo>(HiveBoxes.todo);
    todoBox.add(Todo(title: title));
    Navigator.of(context).pop();
    print(todoBox);
  }

}