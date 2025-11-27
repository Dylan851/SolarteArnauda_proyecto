import 'package:flutter/material.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/locale_bloc/locale_bloc.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/config/utils/lenguage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Punto de entrada de la aplicación
void main() async {
  // Inicializar Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// Widget raíz de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configurar proveedores de estado (BLoC para idioma)
    return MultiBlocProvider(
      providers: [BlocProvider<LocaleBloc>(create: (_) => LocaleBloc())],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          // Configurar idioma y tema de la aplicación
          return MaterialApp(
            locale: state.selectedLanguage.localeValue,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const PantallaPrincipal(),
            routes: {'/login': (context) => const PantallaPrincipal()},
          );
        },
      ),
    );
  }
}
