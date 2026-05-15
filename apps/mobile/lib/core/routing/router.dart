import 'package:go_router/go_router.dart';
import 'package:mobile/core/routing/rout_names.dart';
import 'package:mobile/features/auth/presentation/auth_page.dart';
import 'package:mobile/features/home/presentation/home_page.dart';
import 'package:mobile/features/splash/presentation/pages/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(path: Routes.splash, builder: (context, state) => const SplashPage()),
    GoRoute(path: Routes.login, builder: (context, state) => const AuthPage()),
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
  ],
);
