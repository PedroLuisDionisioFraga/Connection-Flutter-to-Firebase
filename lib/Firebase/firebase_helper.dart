import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class FirebaseHelper {
  static late final FirebaseApp _app;
  static late final FirebaseAuth _auth;
  static const String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDpgYG5jDUvE6Xv88OVt_92z03MEfDEanU";
  static late String _verificationId;

  static Future<void> firebaseConnection() async {
    /*FirebaseOptions _options = FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    );*/
    WidgetsFlutterBinding.ensureInitialized();
    _app = await Firebase.initializeApp(
      name: "Authentication Test",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Connection Success");
    print("_app: $_app");
    _auth = FirebaseAuth.instanceFor(app: _app);
  }

  // Methods
  static Future<void> signUp({required String name, required String email, required String password, String? phone}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // TODO: NÃO FUNCIONA ADICIONAR DISPLAYNAME
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await userCredential.user!.sendEmailVerification();
      }
      //print(phone);
      /*
      if (phone != null) {
        verifyPhoneNumber(phoneNumber: phone);
      }*/
      // usuário criado com sucesso
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.emailVerified) {
        return userCredential.user!;
      }
      return null;
      /*  Guarda o login localmente
      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }*/
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return null;
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print("Log Out error: ${e.code}");
    }
  }

  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Log Out error: ${e.code}");
    }
  }

  static Future<void> deleteAccount({required String email}) async {
    if (_auth.currentUser == null) {
      print("You are not logged");
      return;
    }
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print("Log Out error: ${e.code}");
    }
  }
/*
  static Future<void> updateEmail({required String newEmail}) async {
    try {
      await _auth.currentUser!.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}");
    } catch (e) {
      print("Error: $e");
    }
  }*/

  static Future<void> updatePasswordViaEmail({required String email}) async {
    // await _auth.sendPasswordResetEmail(email: email).then((value) {
    //   print("value: enviado");
    // });

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}, e a mensagem é ${e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> getAllUserInfo() async {
    User? actualUser = _auth.currentUser;
    if (actualUser != null) {
      print(
        """
        Nome: ${actualUser.displayName}
        Email: ${actualUser.email}
        Verificou Email?: ${actualUser.emailVerified}
        É anônimo: ${actualUser.isAnonymous}
        Telefone: ${actualUser.phoneNumber}
        URL da Foto de Perfil: ${actualUser.photoURL}
        User ID: ${actualUser.uid}
        Provider Data: ${actualUser.providerData}
        ID Token: ${actualUser.getIdToken()}
        """,
      );
    }
  }

  static Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    if (_auth.currentUser == null) {
      return;
    }
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneCredential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print("Failed to verify phone number: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Save the verification id somewhere so that you can use it later
        // to build the credential for phone number authentication.
        _verificationId = verificationId;
        print("Verification code sent to $phoneNumber and verificatinId is $verificationId");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Auto retrieval timeout");
      },
      timeout: const Duration(seconds: 60),
    );
  }

  static Future<void> updatePhone({required String smsCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      await _auth.currentUser!.updatePhoneNumber(credential);
      print("Phone updated");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
