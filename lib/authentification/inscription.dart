import 'package:flutter/material.dart';
import 'package:myquicknotes/authentification/connexion.dart';
import 'package:myquicknotes/database.dart';
import 'package:myquicknotes/modele/users.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  bool isvisible = false;
  bool ischecked = false;

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/logo.png"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Créer  Votre Compte !',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Inscrivez-vous dès maintenant !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                ),
                //Nom d'utilisateur
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nom d'utilisateur",
                      border: InputBorder.none,
                      icon: Icon(Icons.person_2),
                    ),
                  ),
                ),

                //Nom d'utilisateur mot de passse
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },

                    obscureText: isvisible,
                    decoration: InputDecoration(
                      hintText: "Passeword",
                      border: InputBorder.none,
                      icon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: Icon(
                          isvisible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ),
                //confirmation de mot de passe
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextFormField(
                    controller: confirmpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "confirmpassword is required";
                      } else if (password.text != confirmpassword.text) {
                        return "Password don't match";
                      }
                      return null;
                    },

                    obscureText: isvisible,
                    decoration: InputDecoration(
                      hintText: "Passeword",
                      border: InputBorder.none,
                      icon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: Icon(
                          isvisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                ListTile(
                  leading: Checkbox(
                    value: ischecked,
                    onChanged: (bool? value) {
                      setState(() {
                        ischecked = value ?? false;
                      });
                    },
                  ),

                  title: Text(
                    "J'accepte les CGU et politique de confidentialités.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.blueGrey, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        final db = UserDb();
                        db
                            .signup(
                              Users(
                                usrName: username.text,
                                usrPassword: password.text,
                                id: null,
                                VALUES: null,
                              ),
                            )
                            .whenComplete(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            });
                      }
                    },
                    child: Text(
                      "Créer Mon Compte",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous avez déjà un compte !"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text("Se Connecter"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
