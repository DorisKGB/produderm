import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/bloc_application/b_application.dart';
import 'src/utils/bloc_pattern/bloc_provider.dart';

void main() async {
  runApp(
    // inyecta en el arbol el BApplication y MyApp
    BlocProvider(
      child: const MyApp(), // vista
      blocBuilder: () => BApplication(), // logica del negocios
    ),
  );
}
