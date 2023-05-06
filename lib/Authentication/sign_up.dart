import 'package:firebase_authentication/Firebase/firebase_helper.dart';
import 'package:firebase_authentication/Shared/regex.dart';
import 'package:firebase_authentication/main.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phone = TextEditingController();

  bool showPassword = false; // Trocar para 'true'
  bool showConfirmPassword = false; // Trocar para 'true'

  final FocusNode field1Focus = FocusNode();
  final FocusNode field2Focus = FocusNode();
  final FocusNode field3Focus = FocusNode();

  void changingVisibilityOfPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void changingVisibilityOfConfirmPassword() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
    phone.dispose();
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
                key: formKey, // keyEEEEEEEEE
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    //! Usuário
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: username,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        // Mudando o botão de ação (O último inferior esquerdo)
                        textInputAction: TextInputAction.next,
                        validator: (user) {
                          if (user == null || user.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          if (user.isInvalidUser()) {
                            return "User inválido";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email,
                          ),
                          labelText: "Usuário*",
                          //helperText: "",
                        ),
                      ),
                    ),
                    //! Email
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
                          labelText: "E-mail*",
                          hintText: "seuemail@gmail.com",
                          //helperText: "",
                        ),
                      ),
                    ),
                    //! Senha
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
                        textInputAction: TextInputAction.next,
                        /**
                         * O motivo pelo qual usamos onEditingComplete é porque essa propriedade é acionada somente quando o usuário pressiona a tecla "concluir" no teclado, enquanto que onFieldSubmitted é acionado tanto quando o usuário pressiona a tecla "próximo" quanto a tecla "concluir".
                         */
                        onEditingComplete: () {
                          // ISSO É PRA MANDAR O FOCO PRA ONDE QUERO
                          field2Focus.requestFocus();
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
                          labelText: "Senha*",
                          //helperText: "",
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              changingVisibilityOfPassword();
                            },
                          ),
                        ),
                      ),
                    ),
                    //! Confirmar Senha
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        focusNode: field2Focus,
                        textAlignVertical: TextAlignVertical.center,
                        controller: confirmPassword,
                        maxLines: 1,
                        obscureText: showConfirmPassword,
                        textInputAction: TextInputAction.next,
                        /**
                         * O motivo pelo qual usamos onEditingComplete é porque essa propriedade é acionada somente quando o usuário pressiona a tecla "concluir" no teclado, enquanto que onFieldSubmitted é acionado tanto quando o usuário pressiona a tecla "próximo" quanto a tecla "concluir".
                         */
                        onEditingComplete: () {
                          // ISSO É PRA MANDAR O FOCO PRA ONDE QUERO
                          FocusScope.of(context).requestFocus(field3Focus);
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
                          labelText: "Confirmar Senha*",
                          suffixIcon: IconButton(
                            icon: Icon(
                              showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              changingVisibilityOfConfirmPassword();
                            },
                          ),
                        ),
                      ),
                    ),
                    //! Telefone
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: phone,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(icon: Icon(Icons.phone), labelText: "Telefone", hintText: "(DDD) x-xxxx-xxxx"),
                      ),
                    ),
                    //! Botão
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15, top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (password.text == confirmPassword.text) {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                FirebaseHelper.signUp(name: username.text, email: email.text, password: password.text, phone: phone.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const MyHomePage();
                                  }),
                                );
                              }
                            } else {
                              // Fazer um aviso aqui
                            }
                          },
                          child: const Text("Cadastro"),
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
