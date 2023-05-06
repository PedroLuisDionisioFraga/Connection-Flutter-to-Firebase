import 'package:firebase_authentication/Firebase/firebase_helper.dart';
import 'package:firebase_authentication/Shared/regex.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SecondStepAuthentication extends StatefulWidget {
  const SecondStepAuthentication({super.key});

  @override
  State<SecondStepAuthentication> createState() => _SecondStepAuthenticationState();
}

class _SecondStepAuthenticationState extends State<SecondStepAuthentication> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phone = TextEditingController();
  final TextEditingController token = TextEditingController();

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
                        controller: phone,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: '(##) # ####-####',
                            filter: {'#': RegExp(r'[0-9]')},
                          ),
                        ],
                        validator: (phoneNumber) {
                          if (phoneNumber == null || phoneNumber.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          if (phoneNumber.isNotValidCellPhone()) {
                            return "Número inválido";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: "Telefone",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15, top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            print("+55${phone.text.replaceAll(RegExp(r'[^0-9]'), '')}");
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              FirebaseHelper.verifyPhoneNumber(phoneNumber: "+55${phone.text.replaceAll(RegExp(r'[^0-9]'), '')}");
                            }
                          },
                          child: const Text("Enviar Token"),
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
                        controller: token,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.token),
                          labelText: "Token",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15, top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            print("+55${phone.text.replaceAll(RegExp(r'[^0-9]'), '')}");
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              FirebaseHelper.updatePhone(smsCode: token.text);
                              print(FirebaseHelper.getAllUserInfo());
                            }
                          },
                          child: const Text("Cadastrar Telefone"),
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
