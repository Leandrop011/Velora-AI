
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    // * Home screen
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    // * Prompt Basic Screen
    GoRoute(
      path: '/basic-prompt',
      builder: (context, state) => BasicPromptScreen(),
    ),
  ],
);