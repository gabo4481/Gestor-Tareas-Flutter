import 'package:flutter/material.dart';
import 'package:gestor_tareas_supabase/page/PageTodoList.dart';
import 'components/Colores_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor Tareas',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColor.background,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
          error: AppColor.error,
          surface: AppColor.background,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColor.textPrimary,
          onError: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColor.textPrimary),
          bodyMedium: TextStyle(color: AppColor.textSecondary),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.accent,
          foregroundColor: Colors.white,
        ),
      ),
      home: const PageTodoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
