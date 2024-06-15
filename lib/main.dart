import 'package:flutter/material.dart';
import 'package:login_seccion/providers/usuraios_provider.dart';
import 'package:login_seccion/screen/home.dart';
import 'package:login_seccion/screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Usuarios_Provider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Aplicación',
          routes: {
            'login': (_) => login_screen(),
            'home': (_) => home_screen(),
          },
          initialRoute: 'login',
        ),
      );
  }
}