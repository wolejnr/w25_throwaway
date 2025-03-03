import 'package:flutter/material.dart';
import 'package:w25_test_flutter/database.dart';
import 'package:w25_test_flutter/todo_dao.dart';
import 'todo_item.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // Define the list for the ListView
  var words = <TodoItem>[];

  late TodoDao myDAO;

  // Textfield controller
  final TextEditingController _input = TextEditingController();

  @override
  void initState() {
    super.initState();

    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((database){
      myDAO = database.todoDao;
      myDAO.getAllItems().then((listOfItems){
        setState(() {
          words.clear();
          words.addAll(listOfItems);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView Demo"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to the second page"),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _input,
                  decoration: const InputDecoration(hintText: "Type here"),
                )),
                ElevatedButton(
                    onPressed: () {
                      if (_input.value.text.isNotEmpty) {
                        setState(() {
                          var newItem = TodoItem(TodoItem.ID++, _input.value.text);
                          myDAO.insertItem(newItem);
                          words.add(newItem);
                          _input.text = "";
                        });
                      } else {
                        const snackBar =
                            SnackBar(content: Text("No input entered"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Add Item"))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: words.length,
                  itemBuilder: (context, rowNum) {
                    return GestureDetector(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete?"),
                                content:
                                    const Text("Are you sure you want to delete"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          myDAO.deleteItem(words[rowNum]);
                                          words.removeAt(rowNum);
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text("Yes")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"))
                                ],
                              );
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Row Number: $rowNum"),
                          Text(words[rowNum].todoItem)
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
