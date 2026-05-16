import 'package:go_router/go_router.dart';
import 'package:budgetro/core/routing/rout_names.dart';
import 'package:budgetro/features/auth/presentation/pages/login_page.dart';
import 'package:budgetro/features/auth/presentation/pages/sign_up_page.dart';
import 'package:budgetro/features/home/presentation/home_page.dart';
import 'package:budgetro/features/splash/presentation/pages/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(path: Routes.splash, builder: (context, state) => const SplashPage()),
    GoRoute(path: Routes.signUp, builder: (context, state) => const SignUpPage()),
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
  ],
);
