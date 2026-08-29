import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/config/router/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:gemini_app/config/theme/app_theme.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';

// ! SECTION - 03 CONECTION WITH THE BACKEND BUT TO SEND FILES
void main() async{

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // ? cambiar el overlay del dispositivo, para el tema darck
  AppTheme.setSystemUiOverlayStyle(isDarckMode: true);

  // ? .env
  await dotenv.load(fileName: '.env');

  // ? Obligar a tener siempre la orientacion vertical
  await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
  ]);

  // ? SPLASH SCREEN
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(const ProviderScope(child: MainApp())); 
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context, ref) {
    // ? Splash screen se lo remueve cuando 
    // ? la app esta construida correctamente
    FlutterNativeSplash.remove();
    final valueThemeApp = ref.watch(appThemeValueProvider).value;
    final valueFountApp = ref.watch(appFountValueProvider).value;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarckMode: valueFountApp, colorValue: valueThemeApp).getTheme(),
    );
  }
}
