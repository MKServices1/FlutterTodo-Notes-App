import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_fire/screens/home.dart';

class EditTodo extends StatefulWidget {
  DocumentSnapshot docid;
  EditTodo({Key? key, required this.docid}) : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('title'));
    content = TextEditingController(text: widget.docid.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home())));
            },
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() =>
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Home())));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Please Enter the Title',
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: content,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: "Please Enter Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
