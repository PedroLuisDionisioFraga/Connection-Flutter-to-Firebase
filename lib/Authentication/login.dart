import 'package:firebase_authentication/Firebase/firebase_helper.dart';
import 'package:firebase_authentication/Shared/regex.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'recover_credencials.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool showPassword = true;

  void changingVisibilityOfPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void dispose() {
    password.dispose();
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
                        controller: email,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          if (email.isInvalidEmail()) {
                            return "Email inválido";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email,
                          ),
                          labelText: "E-mail",
                          //helperText: "",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: password,
                        maxLines: 1,
                        obscureText: showPassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            print("Email ${email.text} e senha ${password.text}");
                            // Aqui você pode fazer a lógica de autenticação e navegar para outra tela
                          }
                        },
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
                          labelText: "Senha",
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
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15, top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseHelper.login(email: email.text, password: password.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const RecoverCredencial();
                              }),
                            );
                          },
                          child: const Text("Recuperar Credenciais"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15, top: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print("Email ${email.text} e senha ${password.text}");
                              bool canLogger = await FirebaseHelper.login(email: email.text, password: password.text);
                              // Aqui você pode fazer a lógica de autenticação e navegar para outra tela
                              if (canLogger) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const MyHomePage();
                                  }),
                                );
                              }
                            }
                          },
                          child: const Text("Login"),
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
