import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire/screens/home.dart';

class AddNewTodo extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('Todo');

  AddNewTodo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          MaterialButton(
              child: const Text('Save'),
              onPressed: () {
                ref.add({
                  'title': title.text,
                  'content': content.text
                }).whenComplete(() => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home())));
              }),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                    labelText: "Title",
                    hintText: "Please Enter Title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: content,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Please Enter Description',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
