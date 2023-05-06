# Primeiramente

[Instale e inicialize os SDKs do Firebase para Flutter](https://github.com/PedroLuisDionisioFraga/Connection-Flutter-to-Firebase), caso ainda não tenha feito isso.

## Usando o Firebase Authentication

1) Adicione sua dependência em `pubspeck.yaml`
```
firebase_auth: ^4.5.0
```
2) Use a classe **FirebaseHelper** para se conectar/cadastrar/desconectar, entre outros comandos disponíveis.

Obs: Acesse a documentação neste[link](https://firebase.google.com/docs/reference/rest/auth?hl=pt-br#section-sign-in-email-password)

https://blog.codemagic.io/flutter-web-firebase-authentication-and-google-sign-in/

## Gerando SHA-1 e SHA-256 para habilitar o envio de SMS, n sei pq tem q usar mas sei q TEM que usar

1) Navegue até a pasta onde está instalado o Java no seu computador usando o comando cd. Por exemplo: cd C:\Program Files\Java\jdk1.8.0_281\bin
2) Execute o comando keytool -list -v -keystore "C:\Users\<nome do usuário>\.android\debug.keystore" para visualizar as informações da chave de depuração. Substitua <nome do usuário> pelo nome do usuário do seu computador. A senha padrão da chave de depuração é **android**.
3)(NÃO É NECESSÁRIO MAS SE SER ERRO TENTE ISSO) Para gerar a chave SHA-1 para uma chave de liberação, substitua o caminho da chave de depuração pelo caminho da chave de liberação. Por exemplo: keytool -list -v -keystore "C:\Users\<nome do usuário>\.android\my-release-key.keystore", substitua my-release-key.keystore pelo nome do seu arquivo de chave de liberação.