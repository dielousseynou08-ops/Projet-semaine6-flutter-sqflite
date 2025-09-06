import 'package:flutter/material.dart';
import 'package:myquicknotes/database.dart';
import 'package:myquicknotes/modele/note_modele.dart';
import 'package:myquicknotes/notes.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final fromkey = GlobalKey<FormState>();

  final db = UserDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Note",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.mode))],
      ),

      body: Form(
        key: fromkey,

        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(8),
                ),
                child: TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Titre',
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(10),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(8),
                ),
                child: TextFormField(
                  maxLength: 100,
                  controller: content,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "content required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    //label: Text("Content :",),
                    border: InputBorder.none,
                    hintText: 'Contenu',
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.blueGrey, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: TextButton(
                        onPressed: () {
                          if (fromkey.currentState!.validate()) {
                            db
                                .createNote(
                                  Notes(
                                    noteTitle: title.text,
                                    noteContent: content.text,
                                    createdAt: DateTime.now().toIso8601String(),
                                  ),
                                )
                                .whenComplete(() {
                                  Navigator.of(context).pop(true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NotePage(),
                                    ),
                                  );
                                });
                          }
                        },
                        child: Text(
                          ' Ajouter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        border: Border.all(color: Colors.blueGrey, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotePage(),
                            ),
                          );
                        },
                        child: Text(
                          ' Annuler',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
