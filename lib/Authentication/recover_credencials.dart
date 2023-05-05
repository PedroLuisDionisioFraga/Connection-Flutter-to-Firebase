import 'package:firebase_authentication/Firebase/firebase_helper.dart';
import 'package:firebase_authentication/Shared/regex.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class RecoverCredencial extends StatefulWidget {
  const RecoverCredencial({super.key});

  @override
  State<RecoverCredencial> createState() => _RecoverCredencialState();
}

class _RecoverCredencialState extends State<RecoverCredencial> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController emailRecoverPassword = TextEditingController();

  bool showPassword = true;

  void changingVisibilityOfPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void dispose() {
    emailRecoverPassword.dispose();
    email.dispose();
    formKey.currentState == null ? null : formKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: SizedBox(
            width: maxScreenWidth * 0.8,
            child: Card(
              color: const Color.fromARGB(255, 255, 193, 7),
              child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: emailRecoverPassword,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          if (password.isInvalidPassword().isEmpty) {
                            return null;
                          }
                          return password.isInvalidPassword().first;
                        },
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.lock,
                          ),
                          labelText: "Senha Usando Email",
                          //helperText: "",
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: changingVisibilityOfPassword,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15, top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            print("Senha com email: ${emailRecoverPassword.text}");
                            FirebaseHelper.updatePasswordViaEmail(email: emailRecoverPassword.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const MyHomePage();
                              }),
                            );
                          },
                          child: const Text("Redefinir Senha Usando Email"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
