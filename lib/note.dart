import 'package:flutter/material.dart';
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

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final keywordController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    handler = UserDb();
    notes = handler.getNotes();
    handler.initDB().whenComplete(() {
      setState(() {
        notes = handler.getNotes();
      });
    });

    // Listen to search field changes
    keywordController.addListener(() {
      setState(() {
        searchQuery = keywordController.text.toLowerCase();
      });
    });
  }

  Future<List<Notes>> getAllNotes() async {
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
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(8),
              height: 58,
              width: 350,
              child: SearchBar(
                controller: keywordController,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                hintText: 'Search',
              ),
            ),

            // Notes List
            FutureBuilder<List<Notes>>(
              future: notes,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text("Pas de Notes"));
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      final items = snapshot.data ?? <Notes>[];

                      // Filter notes based on search query
                      final filteredItems = items.where((note) {
                        return note.noteTitle.toLowerCase().contains(
                              searchQuery,
                            ) ||
                            note.noteContent.toLowerCase().contains(
                              searchQuery,
                            );
                      }).toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final note = filteredItems[index];

                          return ListTile(
                            subtitle: Text(
                              DateFormat(
                                "yMd",
                              ).format(DateTime.parse(note.createdAt)),
                            ),
                            title: Text(note.noteTitle),
                            trailing: IconButton(
                              onPressed: () {
                                db.deleteNote(note.noteId!).whenComplete(() {
                                  _refresh();
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            onTap: () {
                              setState(() {
                                titleController.text = note.noteTitle;
                                contentController.text = note.noteContent;
                              });

                              // Show update dialog
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
                                                    titleController.text,
                                                    contentController.text,
                                                    note.noteId,
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
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              label: Text('Title'),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: contentController,
                                            decoration: const InputDecoration(
                                              label: Text('Content'),
                                            ),
                                          ),
                                        ],
                                      ),
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
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      title: const Text(
        "Mes Notes",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(10),
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
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
