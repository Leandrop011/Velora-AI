
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    // * Home screen
    GoRoute(
      path: '/',
      builder: (_, _) => const HomeScreen(),
    ),
    // * Prompt Basic Screen
    GoRoute(
      path: '/basic-prompt',
      builder: (_, _) => const BasicPromptScreen(),
    ),
    // * Screen de las settings de la app
    GoRoute(
      path: '/config-app',
      builder: (_, _) => const ConfigAppScreen(),
    ),
    // * Screen de la informacion de velora
    GoRoute(
      path: '/info-velora',
      builder: (_, _) => const InfoVeloraScreen(),
    ),
  ],
);