# firebase_connection

Abrir o cmd como adm e rodar os comandos que o firebase manda

flutterfire configure --project=authentication-test-72ab6


Learn more about using this file and next steps from the d


https://www.youtube.com/watch?v=U45mIlvbi6s

# Começando o projeto

Temos 2 opções, uma é adicionar os certificados e dependências um a um no seu projeto clicando nos ícones a seguir um por vez:

<div align="center">
  <img src="Assets\Images\android_ios_web.png">
</div>

Porém não é o foco desse projeto, usaremos a opção do flutter para otimizar o processo

<div align="center">
  <img src="Assets\Images\flutter.png">
</div>

## Passo a passo da instalação

### Introdução de com funciona

**FlutterFire CLI** é uma ferramenta de linha de comando (CLI - Command Line Interface) que facilita o processo de configuração e gerenciamento de projetos do Flutter que usam serviços do Firebase. Resumindo, é um conjunto de plugins oficiais do Flutter que permitem que os desenvolvedores integrem facilmente esses recursos do Firebase em seus aplicativos Flutter tornando o processo de desenvolvimento mais eficiente e produtivo.

1) Baixe o [NodeJS](https://nodejs.org/en), a versão recomendada para a maioria dos usuários, e execute o arquivo que baixar para instalar seu compilador e colocá-lo nas variáveis de ambiente.
2) Rode no terminal o seguinte comando para instalar os plugins do firebase.
```
npm install -g firebase-tools
```
3) Instale o [arquivo binário](https://firebase.tools/bin/win/instant/latest).
4) Renomeie o arquivo para **firebase**, crie uma pasta em **C:\\** chamada **src** e dentro dela uma chamada **Firebase** e mova o arquivo pra essa pasta.
5) Dentro dela abra o **cmd** e faça seu login no firebase com os seguintes comandos
```
firebase login
```
Obs: Esse comando abre uma página da Web que se conecta ao localhost na sua máquina. Se você estiver usando uma máquina remota e não tiver acesso ao localhost, execute o comando com a sinalização **--no-localhost**.
Para testar se a CLI está instalada corretamente e acessando sua conta, liste seus projetos do Firebase executando este comando:
```
firebase projects:list
```
A lista exibida precisa conter os mesmos projetos do Firebase exibidos no [Console do Firebase](https://console.firebase.google.com/u/0/?hl=pt).
6) Execute na pasta do seu projeto em flutter que se conectará no firebase os comandos:
```
dart pub global activate flutterfire_cli
```
```
flutterfire configure --project=token_your_project-any_number_or)letter
```
A saída será parecida com ela, concorde com os termos e termine de rodar:
```
i Found 1 Firebase projects. Selecting project authentication-test-72ab6.
✔ Which platforms should your configuration support (use arrow keys & space to select)? · android, ios, web
i Firebase android app com.example.firebase_connection is not registered on Firebase project authentication-test-72ab6.
i Registered a new Firebase android app on Firebase project authentication-test-72ab6.
i Firebase ios app com.example.firebaseConnection is not registered on Firebase project authentication-test-72ab6.
i Registered a new Firebase ios app on Firebase project authentication-test-72ab6.
i Firebase web app firebase_connection (web) is not registered on Firebase project authentication-test-72ab6.
i Registered a new Firebase web app on Firebase project authentication-test-72ab6.

Firebase configuration file lib\firebase_options.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
web       1:383934728885:web:6f8c783611454784958cfc
android   1:383934728885:android:95fc5f46a3ecb5cd958cfc
ios       1:383934728885:ios:bf81c603180f76d9958cfc
```
Com isso, seus apps são registrados automaticamente por plataforma com o Firebase, e um arquivo de configuração lib/firebase_options.dart é adicionado ao seu projeto do Flutter.
7) Importe a biblioteca **firebase_core: ^2.11.0** para acessar o driver de conexão do Firebase e coloque no seu projeto os seguintes imports
```
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```
8) Para abrir uma conexão com o Firebase coloque o seguinte código, preferencialmente antes do `runApp(const MyApp())` e torne a main assíncrona adicionando um **async** antes de abrir os colchetes da função **main()**
```
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Authentication Test",
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    print("Connection Success");
    print("Coleta de dados automática? ${value.isAutomaticDataCollectionEnabled}");
  });
```
9) Depois adicione e comece a usar os [plug-ins do Flutter](https://firebase.google.com/docs/flutter/setup?hl=pt&authuser=0&platform=android#available-plugins) para os produtos do Firebase que quiser.