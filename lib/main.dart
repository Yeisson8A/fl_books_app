import 'package:fl_books_app/services/books_service.dart';
import 'package:fl_books_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(AppState());

// Widget con los providers que serán globales para toda la aplicación
class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => BooksService(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: 'main',
      routes: {
        'main': ( _ ) => const MainScreen(),
        'book_list': ( _ ) => const BookListScreen(),
        'details': ( _ ) => const DetailsBookScreen()
      },
    );
  }
}
