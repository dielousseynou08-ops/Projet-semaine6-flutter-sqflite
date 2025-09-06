/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myquicknotes/ajout_notes.dart';
import 'package:myquicknotes/database.dart';
import 'package:myquicknotes/modele/note_modele.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late UserDb handler;
  late Future<List<Notes>> notes;
  final db = UserDb();

  final title = TextEditingController();
  final content = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = UserDb();
    notes = handler.getNotes();

    handler.initDB().whenComplete(() {
      notes = handler.getNotes();
    });
    super.initState();
  }

  Future<List<Notes>> getAllNotes() {
    return handler.getNotes();
  }

  Future<void> _refresh() async {
    setState(() {
      notes = getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsetsGeometry.fromLTRB(20, 10, 20, 10),
              padding: EdgeInsets.all(8),
              height: 58,
              width: 350,

              child: SearchBar(
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                hintText: 'Search',
              ),
            ),

            //liste listview
            FutureBuilder<List<Notes>>(
              future: notes,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text("Pas de Notes"));
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      final items = snapshot.data ?? <Notes>[];
                      return ListView.builder(
                        shrinkWrap: true,

                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle: Text(
                              DateFormat(
                                "yMd",
                              ).format(DateTime.parse(items[index].createdAt)),
                            ),
                            title: Text(items[index].noteTitle),
                            trailing: IconButton(
                              onPressed: () {
                                db
                                    .deleteNote(items[index].noteId!)
                                    .whenComplete(() {
                                      _refresh();
                                    });
                              },
                              icon: Icon(Icons.delete),
                            ),
                            onTap: () {
                              setState(() {
                                title.text = items[index].noteTitle;
                                content.text = items[index].noteContent;
                              });
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              db
                                                  .updateNote(
                                                    title.text,
                                                    content.text,
                                                    items[index].noteId,
                                                  )
                                                  .whenComplete(() {
                                                    _refresh();
                                                    Navigator.pop(context);
                                                  });
                                            },
                                            child: const Text('Update'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      ),
                                    ],
                                    title: const Text('Update note'),
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          controller: title,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Title is required ";
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            label: Text('Title'),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: content,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "content is required ";
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            label: Text('Content'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  },
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => new Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      title: Text(
        "Mes Notes",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(10),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateNote()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}*/
