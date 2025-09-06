import 'package:flutter/material.dart';
import 'package:myquicknotes/authentification/inscription.dart';
import 'package:myquicknotes/database.dart';
import 'package:myquicknotes/notes.dart';
import 'package:myquicknotes/modele/users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool isvisible = false;
  bool ischecked = false;
  bool isloginTrue = false;

  final db = UserDb();

  login() async {
    var reponse = await db.login(
      Users(
        usrName: username.text,
        usrPassword: password.text,
        id: null,
        VALUES: null,
      ),
    );
    if (reponse == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotePage()),
      );
    } else {
      setState(() {
        isloginTrue = true;
      });
    }
  }

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
                    'Acceder à Votre Compte !',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Connectez-vous à votre Compte dès maintenant !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                ),
                //Nom d'utilisateur
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(4),
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
                  padding: EdgeInsetsGeometry.all(4),
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
                        login();
                      }
                    },
                    child: Text(
                      "Se connecter",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                //if (formkey.currentState!.validate()) {}
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous n'etes pas encore inscrit !"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SingUp(),
                          ),
                        );
                      },
                      child: Text("S'inscrir"),
                    ),
                  ],
                ),

                isloginTrue
                    ? const Text(
                        "Nom d'utilisateur ou mot de passe incorrect !",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
