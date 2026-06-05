import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

// Core
import 'core/theme.dart';

// Auth Feature
import 'features/auth/data/auth_repository.dart';
import 'features/auth/presentation/auth_view_model.dart';
import 'features/auth/presentation/login_view.dart';

// Books Feature
import 'features/books/data/books_repository.dart';
import 'features/books/presentation/books_view_model.dart';

void main() {
  // Inyección de dependencias manual (Repositores)
  final authRepository = AuthRepository();
  final booksRepository = BooksRepository();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthViewModel(authRepository: authRepository),
          ),
          ChangeNotifierProvider(
            create: (_) => BooksViewModel(booksRepository: booksRepository),
          ),
        ],
        child: const BookShelfApp(),
      ),
    ),
  );
}

class BookShelfApp extends StatelessWidget {
  const BookShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookShelf Club',
      debugShowCheckedModeBanner: false,
      // useInheritedMediaQuery ha sido eliminado en versiones recientes de Flutter
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.getTheme(context),
      home: const LoginView(),
    );
  }
}
