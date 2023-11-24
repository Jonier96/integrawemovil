import 'package:flutter/material.dart';
import 'login_screen.dart'; // Asegúrate de que la ruta sea correcta
import 'registre_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa el paquete de Firebase
import 'firebase_options.dart'; // Importa tu archivo de opciones de Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Usa la configuración de tu archivo
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación de Cócteles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[900],
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
