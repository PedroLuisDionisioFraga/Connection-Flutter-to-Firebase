import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/firebase_options.dart';

Future<void> main() async {
  // Garante que o Flutter esteja totalmente inicializado antes de prosseguir com a conexão ao Firebase.
  // Isso é importante porque o Firebase depende de alguns recursos do Flutter que podem não estar disponíveis
  // imediatamente quando o aplicativo é iniciado. Ao chamar ensureInitialized(), você está garantindo que
  // esses recursos estejam prontos para uso antes de tentar se conectar ao Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  // Inicia o Firebase em um aplicativo Flutter
  await Firebase.initializeApp(
    name: "Core Test",
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    print("Connection Success");
    print("Coleta de dados automática? ${value.isAutomaticDataCollectionEnabled}");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
