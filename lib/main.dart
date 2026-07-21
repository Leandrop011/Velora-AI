import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/config/router/app_router.dart';
import 'package:gemini_app/config/theme/app_theme.dart';

// ! SECTION - 02 CONECTION WITH THE BACKEND
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  AppTheme.setSystemUiOverlayStyle(isDarckMode: true);

  // ? SPLASH SCREEN
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(ProviderScope(child: const MainApp())); 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    // ? Splash screen se lo remueve cuando 
    // ? la app esta construida correctamente
    FlutterNativeSplash.remove();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarckMode: true).getTheme(),
    );
  }
}
